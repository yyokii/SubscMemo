//
//  ExploreSubscRepository.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/12/15.
//

import Combine

import FirebaseFirestore

class BaseExploreSubscRepository {
    @Published var items = [ExploreSubscItem]()
}

/// 公開されているサブスクリプションサービスへのデータアクセス
protocol ExploreSubscRepository: BaseExploreSubscRepository {
    func loadData() -> AnyPublisher<[ExploreSubscItem], Error>
    func loadData(with serviceIDs: [String]) -> AnyPublisher<[ExploreSubscItem], Error>
    func loadPlans(of serviceID: String) -> AnyPublisher<[ExploreSubscItem.SubscPlan], Error>
}

final class FirestoreExploreSubscRepository: BaseExploreSubscRepository, ExploreSubscRepository, ObservableObject {

    var db: Firestore = Firestore.firestore()

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
                        self.items = querySnapshot.documents
                            .compactMap { document -> ExploreSubscItem? in
                                try? document.data(as: ExploreSubscItem.self)
                            }
                        promise(.success(self.items))
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
