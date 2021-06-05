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
    func loadData()
    func loadData(with serviceID: String) -> AnyPublisher<SubscribedItemJoinedData, Error>
}

final class FirestoreSubscribedServiceRepository: BaseSubscribedServiceRepository, SubscribedServiceRepository, ObservableObject {

    var db: Firestore = Firestore.firestore()

    @Injected var authenticationService: AuthenticationService

    @Injected var userProfileRepository: UserProfileRepository
    @Injected var subscCategoryRepository: SubscCategoryRepository

    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()

        loadData()
    }

    func loadData() {
        userProfileRepository.$subscribedServices
            .combineLatest(subscCategoryRepository.$categories)
            .map { (services, categories) -> [SubscribedItemJoinedData] in

                let datas = services.map { service -> SubscribedItemJoinedData in

                    let mainCategoryName = categories.first {
                        $0.id == service.mainCategoryID
                    }?.name ?? ""

                    var subCategoryName: String?
                    if let subCategoryID = service.subCategoryID {
                        subCategoryName = categories.first {
                            $0.id == subCategoryID
                        }?.name
                    }

                    return SubscribedItemJoinedData(createdTime: service.createdTime,
                                                    cycle: service.cycle,
                                                    description: service.description,
                                                    id: service.id,
                                                    iconImageURL: service.iconImageURL,
                                                    isUserOriginal: service.isUserOriginal,
                                                    mainCategoryID: service.mainCategoryID,
                                                    mainCategoryName: mainCategoryName,
                                                    memo: service.memo,
                                                    name: service.name,
                                                    planID: service.planID,
                                                    planName: service.planName,
                                                    price: service.price,
                                                    payAt: service.payAt,
                                                    subCategoryID: service.subCategoryID,
                                                    subCategoryName: subCategoryName,
                                                    serviceID: service.serviceID,
                                                    serviceURL: service.serviceURL)
                }

                return datas
            }
            .assign(to: \.items, on: self)
            .store(in: &cancellables)
    }

    /// 任意のサービスIDのデータを取得する
    func loadData(with serviceID: String) -> AnyPublisher<SubscribedItemJoinedData, Error> {
        let targetData = items.first { item in
            item.id == serviceID
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
}
