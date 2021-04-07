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
    func loadCategory() -> AnyPublisher<[SubscCategory], Error>
}

final class FirestoreExploreSubscRepository: BaseExploreSubscRepository, ExploreSubscRepository, ObservableObject {

    var db: Firestore = Firestore.firestore()

    enum FirestorePathComponent: String {
        case itemsPath = "subscItems"
        case subscriptionServices = "subscription_services"
        case version = "v1"
        case categories = "categories"
    }

    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()

        _ = loadData()
        _ = loadCategory()
    }

    func loadData() -> AnyPublisher<[ExploreSubscItem], Error> {

        return Future<[ExploreSubscItem], Error> { [weak self] promise in

            guard let self = self else {
                promise(.failure(RepositoryError.other))
                return
            }

            self.db.collection(FirestorePathComponent.itemsPath.rawValue)
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
                        promise(.failure(RepositoryError.noValue))
                    }
                }
        }
        .eraseToAnyPublisher()
    }

    func loadCategory() -> AnyPublisher<[SubscCategory], Error> {
        return Future<[SubscCategory], Error> { [weak self] promise in

            guard let self = self else {
                promise(.failure(RepositoryError.other))
                return
            }

            self.db
                .collection(FirestorePathComponent.subscriptionServices.rawValue)
                .document(FirestorePathComponent.version.rawValue)
                .collection(FirestorePathComponent.categories.rawValue)
                .addSnapshotListener { (querySnapshot, error) in

                    if let error = error {
                        promise(.failure(error))
                    }

                    if let querySnapshot = querySnapshot {
                        self.categories = querySnapshot.documents
                            .compactMap { document -> SubscCategory? in
                                try? document.data(as: SubscCategory.self)
                            }
                        promise(.success(self.categories))
                    } else {
                        promise(.failure(RepositoryError.noValue))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
