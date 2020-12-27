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

protocol ExploreSubscRepository: BaseExploreSubscRepository {
    func loadData()
}

final class FirestoreExploreSubscRepository: BaseExploreSubscRepository, ExploreSubscRepository, ObservableObject {

    var db: Firestore = Firestore.firestore()

    let itemsPath: String = "subscItems"

    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()

        loadData()
    }

    func loadData() {

        db.collection(itemsPath)
            .order(by: "createdTime")
            .addSnapshotListener { (querySnapshot, _) in
                if let querySnapshot = querySnapshot {
                    self.items = querySnapshot.documents.compactMap { document -> ExploreSubscItem? in
                        try? document.data(as: ExploreSubscItem.self)
                    }
                }
            }
    }
}
