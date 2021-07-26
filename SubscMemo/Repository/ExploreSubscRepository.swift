//
//  ExploreSubscRepository.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/12/15.
//

import Combine

import FirebaseFirestore
import Resolver

class BaseExploreSubscRepository {
    @Published var exploreSubscItems = [ExploreSubscItem]()
    @Published var exploreItemJoinedDatas = [ExploreItemJoinedData]()
}

/// 公開されているサブスクリプションサービスへのデータアクセス
protocol ExploreSubscRepository: BaseExploreSubscRepository {
    func loadData() -> AnyPublisher<[ExploreSubscItem], Error>
    func loadData(with category: [SubscCategory]) -> AnyPublisher<[ExploreItemJoinedData], Error>
    func loadData(with serviceIDs: [String]) -> AnyPublisher<[ExploreSubscItem], Error>
    func loadJoinedData()
    func loadJoinedData(with serviceID: String) -> AnyPublisher<ExploreItemJoinedData, Error>
    func loadPlans(of serviceID: String) -> AnyPublisher<[ExploreSubscItem.SubscPlan], Error>
}

final class FirestoreExploreSubscRepository: BaseExploreSubscRepository, ExploreSubscRepository, ObservableObject {

    var db: Firestore = Firestore.firestore()
    @Injected var subscCategoryRepository: SubscCategoryRepository

    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()

        _ = loadData()
        loadJoinedData()
    }

    func loadData() -> AnyPublisher<[ExploreSubscItem], Error> {

        return Future<[ExploreSubscItem], Error> { [weak self] promise in

            guard let self = self else {
                promise(.failure(RepositoryError.other))
                return
            }

            self.db
                .collection(FirestorePathComponent.subscriptionServices.rawValue)
                .document(FirestorePathComponent.version.rawValue)
                .collection(FirestorePathComponent.services.rawValue)
                .order(by: "createdTime")
                .addSnapshotListener { (querySnapshot, error) in

                    if let error = error {
                        promise(.failure(error))
                    }

                    if let querySnapshot = querySnapshot {
                        self.exploreSubscItems = querySnapshot.documents
                            .compactMap { document -> ExploreSubscItem? in
                                try? document.data(as: ExploreSubscItem.self)
                            }
                        promise(.success(self.exploreSubscItems))
                    } else {
                        promise(.failure(RepositoryError.notFound))
                    }
                }
        }
        .eraseToAnyPublisher()
    }

    func loadData(with category: [SubscCategory]) -> AnyPublisher<[ExploreItemJoinedData], Error> {

        let categoryIDs = category.map { $0.categoryID }
        let categories = subscCategoryRepository.categories

        return db
            .collection(FirestorePathComponent.subscriptionServices.rawValue)
            .document(FirestorePathComponent.version.rawValue)
            .collection(FirestorePathComponent.services.rawValue)
            .whereField("categoryIDs", arrayContainsAny: categoryIDs)
            .getDocuments()
            .map { snapshot in
                let items =  snapshot.documents
                    .compactMap { document -> ExploreSubscItem? in
                        try? document.data(as: ExploreSubscItem.self)
                    }
                return items
            }
            .map { [weak self] items -> [ExploreItemJoinedData] in
                self?.makeJoinedData(items: items, categories: categories) ?? []
            }
            .eraseToAnyPublisher()
    }

    func loadData(with serviceIDs: [String]) -> AnyPublisher<[ExploreSubscItem], Error> {
        let cachedItems = loadDataFromCache(with: serviceIDs)

        var copyServiceIDs = serviceIDs
        copyServiceIDs.removeAll { id in
            cachedItems.contains { item in
                item.serviceID == id
            }
        }

        if copyServiceIDs.isEmpty {
            return Future<[ExploreSubscItem], Error> { promise in
                promise(.success(cachedItems))
            }.eraseToAnyPublisher()
        } else {
            let serviceCollectionRef = db
                .collection(FirestorePathComponent.subscriptionServices.rawValue)
                .document(FirestorePathComponent.version.rawValue)
                .collection(FirestorePathComponent.services.rawValue)

            return serviceCollectionRef
                .whereField("serviceID", in: copyServiceIDs)
                .order(by: "createdTime")
                .getDocuments()
                .map { snapshot in
                    let items =  snapshot.documents
                        .compactMap { document -> ExploreSubscItem? in
                            try? document.data(as: ExploreSubscItem.self)
                        }
                    return items + cachedItems
                }
                .eraseToAnyPublisher()
        }
    }

    func loadDataFromCache(with serviceIDs: [String]) -> [ExploreSubscItem] {

        return exploreSubscItems.filter { item in
            serviceIDs.contains { id in
                id == item.serviceID
            }
        }
    }

    func loadJoinedData() {
        $exploreSubscItems
            .combineLatest(subscCategoryRepository.$categories)
            .map { [weak self] (items, categories) -> [ExploreItemJoinedData] in
                self?.makeJoinedData(items: items, categories: categories) ?? []
            }
            .assign(to: \.exploreItemJoinedDatas, on: self)
            .store(in: &cancellables)
    }

    func makeJoinedData(items: [ExploreSubscItem], categories: [SubscCategory]) -> [ExploreItemJoinedData] {
        return items.map { item -> ExploreItemJoinedData in

            let categoryNames = item.categoryIDs.compactMap { id in
                categories.first {
                    $0.categoryID == id
                }?.name
            }

            return ExploreItemJoinedData(
                categoryIDs: item.categoryIDs,
                categoryNames: categoryNames,
                createdTime: item.createdTime,
                description: item.description,
                iconImageURL: item.iconImageURL,
                id: item.id,
                name: item.name,
                serviceID: item.serviceID,
                serviceURL: item.serviceURL
            )
        }
    }

    #warning("取得し直すようにしたい")
    /// 任意のサービスIDのデータを取得する
    func loadJoinedData(with serviceID: String) -> AnyPublisher<ExploreItemJoinedData, Error> {
        let targetData = exploreItemJoinedDatas.first { item in
            item.serviceID == serviceID
        }

        if let data = targetData {
            return Future<ExploreItemJoinedData, Error> { promise in
                promise(.success(data))
            }.eraseToAnyPublisher()
        } else {
            return Future<ExploreItemJoinedData, Error> { promise in
                promise(.failure(RepositoryError.notFound))
            }.eraseToAnyPublisher()
        }
    }

    func loadPlans(of serviceID: String) -> AnyPublisher<[ExploreSubscItem.SubscPlan], Error> {
        let serviceCollectionRef = db
            .collection(FirestorePathComponent.subscriptionServices.rawValue)
            .document(FirestorePathComponent.version.rawValue)
            .collection(FirestorePathComponent.services.rawValue)

        return loadData(with: [serviceID])
            .compactMap { [weak self] items in
                guard let id = items.first?.id else {
                    return Fail<[ExploreSubscItem.SubscPlan], Error>(error: RepositoryError.other)
                        .eraseToAnyPublisher()
                }
                let ref = serviceCollectionRef
                    .document(id)
                return self?.loadPlans(with: ref)
            }
            .flatMap(maxPublishers: .max(1)) { loadplan -> AnyPublisher<[ExploreSubscItem.SubscPlan], Error> in
                loadplan
            }
            .eraseToAnyPublisher()
    }

    private func loadPlans(with serviceDocumentRef: DocumentReference) -> AnyPublisher<[ExploreSubscItem.SubscPlan], Error> {
        return serviceDocumentRef
            .collection(FirestorePathComponent.plans.rawValue)
            .getDocuments()
            .map {
                $0.documents.compactMap { doc in
                    try? doc.data(as: ExploreSubscItem.SubscPlan.self)
                }
            }
            .eraseToAnyPublisher()
    }

    func loadPlan(with planID: String, serviceDocumentRef: DocumentReference) -> AnyPublisher<ExploreSubscItem.SubscPlan, Error> {
        return serviceDocumentRef
            .collection(FirestorePathComponent.plans.rawValue)
            .whereField("planID", isEqualTo: planID)
            .getDocuments()
            // これなかったらエラー流れるっけ？いやfinishするだけ
            .compactMap {
                try? $0.documents.first?.data(as: ExploreSubscItem.SubscPlan.self)
            }
            .eraseToAnyPublisher()
    }
}
