//
//  SubscRepository.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/12.
//

import Combine

import CombineFirebaseFirestore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Resolver

class BaseSubscRepository {
    @Published var items = [SubscItem]()
}

/// ユーザーが登録しているサブスクリプションサービスの操作
protocol SubscRepository: BaseSubscRepository {
    func addItem(_ item: SubscItem) -> AnyPublisher<Void, Error>
    func deleteItem(_ item: SubscItem) -> AnyPublisher<Void, Error>
    func updateItem(_ item: SubscItem) -> AnyPublisher<Void, Error>
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
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.loadData()
            }
            .store(in: &cancellables)
    }

    private func loadData() {

        db.collection(usersPath)
            .document(userId)
            .collection(itemsPath)
            .order(by: "createdTime")
            .addSnapshotListener { (querySnapshot, _) in
                if let querySnapshot = querySnapshot {
                    self.items = querySnapshot.documents
                        .compactMap { document -> SubscItem? in
                            try? document.data(as: SubscItem.self)
                        }
                }
            }
    }

    func addItem(_ item: SubscItem) -> AnyPublisher<Void, Error> {

        return db.collection(usersPath)
            .document(userId)
            .collection(itemsPath)
            .addDocument(from: item)
            .map { _ in
                ()
            }.eraseToAnyPublisher()
    }

    func deleteItem(_ item: SubscItem) -> AnyPublisher<Void, Error> {

        if let itemID = item.id {
            return db.collection(usersPath)
                .document(userId)
                .collection(itemsPath)
                .document(itemID)
                .delete()
        } else {
            return Fail<Void, Error>(error: RepositoryError.other)
                .eraseToAnyPublisher()
        }
    }

    // こんな感じで繋げられないかね？
    //    return item.id
    //        .publisher
    //        .compactMap { $0 }
    //        .flatMap{ [weak self] data in
    //            self?.db.collection(usersPath)
    //                .document(userId)
    //                .collection(itemsPath)
    //                .document(data)
    //                .delete() ?? Fail<Void, Error>(error: RepositoryError.other)
    //        }
    //        .eraseToAnyPublisher()

    func updateItem(_ item: SubscItem) -> AnyPublisher<Void, Error> {

        if let itemID = item.id {
            return db.collection(usersPath)
                .document(userId)
                .collection(itemsPath)
                .document(itemID)
                .setData(from: item)
        } else {
            return Fail<Void, Error>(error: RepositoryError.other)
                .eraseToAnyPublisher()
        }
    }
}
