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
    @Published var joinedDatas = [SubscribedItemJoinedData]()
    @Published var subscribedItems = [SubscribedItem]()
}

/**
 ユーザーが登録しているサブスクリプションサービスの操作

 serviceIDをキーにして検索処理などを実行すると、同じサービスを複数登録している場合に一意に決定しないので注意。
 */
protocol SubscribedServiceRepository: BaseSubscribedServiceRepository {
    func addSubscribedItem(data: SubscribedItem) -> AnyPublisher<Void, Error>
    func deleteItem(dataID: String) -> AnyPublisher<Void, Error>
    func loadJoinedData()
    func loadJoinedData(with serviceID: String) -> AnyPublisher<SubscribedItemJoinedData, Error>
    func loadSubscribedItems()
}

final class FirestoreSubscribedServiceRepository: BaseSubscribedServiceRepository, SubscribedServiceRepository, ObservableObject {

    var db: Firestore = Firestore.firestore()

    @Injected var authenticationService: AuthenticationService
    @Injected var subscCategoryRepository: SubscCategoryRepository

    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()

        // (re)load data if user changes
        authenticationService.$user
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.loadSubscribedItems()
                self?.loadJoinedData()
            }
            .store(in: &cancellables)
    }

    func addSubscribedItem(data: SubscribedItem) -> AnyPublisher<Void, Error> {
        let userID = authenticationService.user.id

        return db
            .collection(FirestorePathComponent.userProfile.rawValue)
            .document(FirestorePathComponent.version.rawValue)
            .collection(FirestorePathComponent.users.rawValue)
            .document(userID)
            .collection(FirestorePathComponent.subscribedServices.rawValue)
            .addDocument(from: data)
            .map { _ in () }
            .eraseToAnyPublisher()
    }

    func deleteItem(dataID: String) -> AnyPublisher<Void, Error> {
        let userID = authenticationService.user.id
        return db
            .collection(FirestorePathComponent.userProfile.rawValue)
            .document(FirestorePathComponent.version.rawValue)
            .collection(FirestorePathComponent.users.rawValue)
            .document(userID)
            .collection(FirestorePathComponent.subscribedServices.rawValue)
            .document(dataID)
            .delete()
    }

    func loadJoinedData() {
        $subscribedItems
            .combineLatest(subscCategoryRepository.$categories)
            .map { (services, categories) -> [SubscribedItemJoinedData] in

                return services.map { service -> SubscribedItemJoinedData in

                    let categoryNames = service.categoryIDs.compactMap { categoryID in
                        categories.first {
                            $0.categoryID == categoryID
                        }?.name
                    }

                    return SubscribedItemJoinedData(
                        categoryIDs: service.categoryIDs,
                        categoryNames: categoryNames,
                        createdTime: service.createdTime,
                        cycle: service.cycle,
                        description: service.description,
                        id: service.id,
                        isUserOriginal: service.isUserOriginal,
                        memo: service.memo,
                        name: service.name,
                        planID: service.planID,
                        planName: service.planName,
                        price: service.price,
                        payAt: service.payAt,
                        serviceID: service.serviceID,
                        serviceURL: service.serviceURL
                    )
                }
            }
            .assign(to: \.joinedDatas, on: self)
            .store(in: &cancellables)
    }

    /// 任意のサービスIDのデータを取得する
    func loadJoinedData(with dataID: String) -> AnyPublisher<SubscribedItemJoinedData, Error> {

        let targetData = joinedDatas.first { item in
            item.id == dataID
        }

        if let data = targetData {
            return Future<SubscribedItemJoinedData, Error> { promise in
                promise(.success(data))
            }.eraseToAnyPublisher()
        } else {
            return Future<SubscribedItemJoinedData, Error> { promise in
                promise(.failure(RepositoryError.notFound))
            }.eraseToAnyPublisher()
        }
    }

    func loadSubscribedItems() {
        let userID = authenticationService.user.id

        guard !userID.isEmpty else {
            return
        }

        db.collection(FirestorePathComponent.userProfile.rawValue)
            .document(FirestorePathComponent.version.rawValue)
            .collection(FirestorePathComponent.users.rawValue)
            .document(userID)
            .collection(FirestorePathComponent.subscribedServices.rawValue)
            .order(by: "createdTime")
            .addSnapshotListener { [weak self] (querySnapshot, _) in
                if let querySnapshot = querySnapshot {
                    self?.subscribedItems = querySnapshot.documents
                        .compactMap { document -> SubscribedItem? in
                            try? document.data(as: SubscribedItem.self)
                        }
                }
            }
    }
}
