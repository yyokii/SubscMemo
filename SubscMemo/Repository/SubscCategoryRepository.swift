//
//  SubscCategoryRepository.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/08.
//

import Combine

import FirebaseFirestore

class BaseSubscCategoryRepository {
    @Published var categories = [SubscCategory]()
}

/// サブスクリプションサービスのカテゴリー一覧データへアクセス
protocol SubscCategoryRepository: BaseSubscCategoryRepository {
    func loadCategory() -> AnyPublisher<[SubscCategory], Error>
}

final class FirestoreSubscCategoryRepository: BaseSubscCategoryRepository, SubscCategoryRepository, ObservableObject {

    var db: Firestore = Firestore.firestore()

    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()

        _ = loadCategory()
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
                        promise(.failure(RepositoryError.notFound))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
