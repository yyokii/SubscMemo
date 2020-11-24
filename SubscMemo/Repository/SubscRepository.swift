//
//  SubscRepository.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/12.
//

import Combine

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Resolver

class BaseSubscRepository {
    @Published var items = [SubscItem]()
}

protocol SubscRepository: BaseSubscRepository {
    func addItem(_ item: SubscItem)
    func deleteItem(_ item: SubscItem)
    func updateItem(_ item: SubscItem)
}

final class FirestoreSubscRepository: BaseSubscRepository, SubscRepository, ObservableObject {

    var db: Firestore = Firestore.firestore()

    @Injected var authenticationService: AuthenticationService

    let usersPath: String = "users"
    let itemsPath: String = "subscItems"
    var userId: String = "unknown"

    // private var listenerRegistration: ListenerRegistration?
    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()

        authenticationService.$user
            .compactMap { user in
                user?.id
            }
            .assign(to: \.userId, on: self)
            .store(in: &cancellables)

        // (re)load data if user changes
        authenticationService.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.loadData()
            }
            .store(in: &cancellables)

        // loadData()
    }

    private func loadData() {

        db.collection(usersPath)
            .document(userId)
            .collection(itemsPath)
            .order(by: "createdTime")
            .addSnapshotListener { (querySnapshot, _) in
                if let querySnapshot = querySnapshot {
                    self.items = querySnapshot.documents.compactMap { document -> SubscItem? in
                        try? document.data(as: SubscItem.self)
                    }
                }
            }
    }

    func addItem(_ item: SubscItem) {
        do {
            _ = try db.collection(usersPath)
                .document(userId)
                .collection(itemsPath)
                .addDocument(from: item)
        } catch {
            fatalError("Unable to encode task: \(error.localizedDescription).")
        }
    }

    func deleteItem(_ item: SubscItem) {
        if let itemID = item.id {
            db.collection(usersPath)
                .document(userId)
                .collection(itemsPath)
                .document(itemID).delete { (error) in
                    if let error = error {
                        print("Unable to remove document: \(error.localizedDescription)")
                    }
                }
        }
    }

    func updateItem(_ item: SubscItem) {
        if let itemID = item.id {
            do {
                try db.collection(usersPath)
                    .document(userId)
                    .collection(itemsPath)
                    .document(itemID).setData(from: item)
            } catch {
                fatalError("Unable to encode task: \(error.localizedDescription).")
            }
        }
    }
}
