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
    @Published var categories = [SubscCategory]()
}

/// 公開されているサブスクリプションサービスへのデータアクセス
protocol ExploreSubscRepository: BaseExploreSubscRepository {
    func loadData() -> AnyPublisher<[ExploreSubscItem], Error>
    func loadData(with ids: [String]) -> AnyPublisher<[ExploreSubscItem], Error>
}

final class FirestoreExploreSubscRepository: BaseExploreSubscRepository, ExploreSubscRepository, ObservableObject {

    var db: Firestore = Firestore.firestore()

    enum FirestorePathComponent: String {
        case categories = "categories"
        case plan = "plan"
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

            self.db.collection(FirestorePathComponent.subscriptionServices.rawValue)
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

    func hoge() {

    }

    func loadData(with ids: [String]) -> AnyPublisher<[ExploreSubscItem], Error> {
        let serviceCollectionRef = db.collection(FirestorePathComponent.subscriptionServices.rawValue)
            .document(FirestorePathComponent.version.rawValue)
            .collection(FirestorePathComponent.services.rawValue)

        return serviceCollectionRef
            .whereField("serviceID", in: ids)
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

    func planData(with planID: String, serviceDocumentRef: DocumentReference) -> AnyPublisher<ExploreSubscItem.SubscPlan, Error> {

        return serviceDocumentRef
            .collection(FirestorePathComponent.plan.rawValue)
            .whereField("planID", isEqualTo: planID)
            .getDocuments()
            // これなかったらエラー流れるっけ？いやfinishするだけ
            .compactMap {
                try? $0.documents.first?.data(as: ExploreSubscItem.SubscPlan.self)
            }
            .eraseToAnyPublisher()
    }
}
