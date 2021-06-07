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
    func loadData(with serviceIDs: [String]) -> AnyPublisher<[ExploreSubscItem], Error>
    func loadJoinedData()
    func loadJoinedData(with serviceID: String) -> AnyPublisher<ExploreItemJoinedData, Error>
    func loadPlans(of serviceID: String) -> AnyPublisher<[ExploreSubscItem.SubscPlan], Error>
}

final class FirestoreExploreSubscRepository: BaseExploreSubscRepository, ExploreSubscRepository, ObservableObject {

    var db: Firestore = Firestore.firestore()
    @Injected var subscCategoryRepository: SubscCategoryRepository

    enum FirestorePathComponent: String {
        case plans = "plans"
        case subscriptionServices = "subscription_services"
        case services = "services"
        case version = "v1"
    }

    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()

        _ = loadData()
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

    func loadData(with serviceIDs: [String]) -> AnyPublisher<[ExploreSubscItem], Error> {
        let serviceCollectionRef = db
            .collection(FirestorePathComponent.subscriptionServices.rawValue)
            .document(FirestorePathComponent.version.rawValue)
            .collection(FirestorePathComponent.services.rawValue)

        return serviceCollectionRef
            .whereField("serviceID", in: serviceIDs)
            .order(by: "createdTime")
            .getDocuments()
            .map { snapshot in
                snapshot.documents
                    .compactMap { document -> ExploreSubscItem? in
                        try? document.data(as: ExploreSubscItem.self)
                    }
            }
            .eraseToAnyPublisher()
    }

    func loadJoinedData() {
        $exploreItemJoinedDatas
            .combineLatest(subscCategoryRepository.$categories)
            .map { (items, categories) -> [ExploreItemJoinedData] in

                return items.map { item -> ExploreItemJoinedData in

                    let mainCategoryName = categories.first {
                        $0.id == item.mainCategoryID
                    }?.name ?? ""

                    var subCategoryName: String?
                    if let subCategoryID = item.subCategoryID {
                        subCategoryName = categories.first {
                            $0.id == subCategoryID
                        }?.name
                    }

                    return ExploreItemJoinedData(
                        createdTime: item.createdTime,
                        description: item.description,
                        id: item.id,
                        iconImageURL: item.iconImageURL, mainCategoryID: item.mainCategoryID,
                        mainCategoryName: mainCategoryName,
                        name: item.name,
                        subCategoryID: item.subCategoryID,
                        subCategoryName: subCategoryName,
                        serviceID: item.serviceID,
                        serviceURL: item.serviceURL
                    )

                }
            }
            .assign(to: \.exploreItemJoinedDatas, on: self)
            .store(in: &cancellables)
    }

    /// 任意のサービスIDのデータを取得する
    func loadJoinedData(with serviceID: String) -> AnyPublisher<ExploreItemJoinedData, Error> {
        let targetData = exploreItemJoinedDatas.first { item in
            item.id == serviceID
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

    #warning("つくったけど今使わないかも・・・")
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
