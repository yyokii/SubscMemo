//
//  SubscribedServiceRepository.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/15.
//

import Combine

import CombineFirebaseFirestore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Resolver

class BaseSubscribedServiceRepository {
    @Published var items = [SubscribedItemJoinedData]()
}

/// ユーザーが登録しているサブスクリプションサービスの操作
protocol SubscribedServiceRepository: BaseSubscribedServiceRepository {
}

final class FirestoreSubscribedServiceRepository: BaseSubscribedServiceRepository, SubscribedServiceRepository, ObservableObject {

    var db: Firestore = Firestore.firestore()

    @Injected var authenticationService: AuthenticationService

    @Injected var userProfileRepository: UserProfileRepository
    @Injected var subscCategoryRepository: SubscCategoryRepository

    let usersPath: String = "users"
    let itemsPath: String = "subscItems"
    var userId: String = "unknown"

    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()

        //        authenticationService.$user
        //            .compactMap { user in
        //                user?.id
        //            }
        //            .assign(to: \.userId, on: self)
        //            .store(in: &cancellables)

        // (re)load data if user changes
        authenticationService.$user
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                //   self?.loadData()
            }
            .store(in: &cancellables)
    }
}
