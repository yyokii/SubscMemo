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
    func loadCategory()
}

final class FirestoreSubscCategoryRepository: BaseSubscCategoryRepository, SubscCategoryRepository, ObservableObject {

    let db: Firestore = Firestore.firestore()

    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()

        loadCategory()
    }

    func loadCategory() {
        db
            .collection(FirestorePathComponent.subscriptionServices.rawValue)
            .document(FirestorePathComponent.version.rawValue)
            .collection(FirestorePathComponent.categories.rawValue)
            .getDocuments(as: SubscCategory.self)
            .replaceError(with: categories)
            .assign(to: \.categories, on: self)
            .store(in: &cancellables)
    }
}
