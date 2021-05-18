//
//  UserProfileRepository.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/15.
//

import Combine

import FirebaseFirestore
import FirebaseFirestoreSwift
import Resolver

class BaseUserProfileRepository {
    @Published var appUser: AppUser!
    @Published var subscribedServices = [SubscribedItem]()
}

/// ユーザーのプロフィール情報を操作する
protocol UserProfileRepository: BaseUserProfileRepository {
    func loadSubscribedServices()
    func loginWithEmail(email: String, pass: String) -> AnyPublisher<AppUser, Error>
    func signUpWithEmail(email: String, pass: String) -> AnyPublisher<AppUser, Error>
    func signOut() -> AnyPublisher<Void, Error>
}

final class FirestoreUserProfileRepository: BaseUserProfileRepository, UserProfileRepository, ObservableObject {

    @Injected var authenticationService: AuthenticationService

    private var cancellables = Set<AnyCancellable>()
    private var db: Firestore = Firestore.firestore()
    private var userId: String = ""

    enum FirestorePathComponent: String {
        case originalSubscriptionServices = "original_subscription_services"
        case subscriptionServices = "subscription_services"
        case userProfile = "user_profile"
        case users = "users"
        case version = "v1"
    }

    override init() {
        super.init()

        authenticationService.$user
            .assign(to: \.appUser, on: self)
            .store(in: &cancellables)

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
                self?.loadSubscribedServices()
            }
            .store(in: &cancellables)
    }

    func loadSubscribedServices() {
        //        db.collection(FirestorePathComponent.userProfile.rawValue)
        //            .document(FirestorePathComponent.version.rawValue)
        //            .collection(FirestorePathComponent.users.rawValue)
        //            .document(userId)
        //            .collection(FirestorePathComponent.subscriptionServices.rawValue)
        //            .order(by: "createdTime")
        //            .addSnapshotListener { [weak self] (querySnapshot, _) in
        //                if let querySnapshot = querySnapshot {
        //                    self?.subscribedServices = querySnapshot.documents
        //                        .compactMap { document -> SubscribedService? in
        //                            try? document.data(as: SubscribedService.self)
        //                        }
        //                }
        //            }
    }

    func loginWithEmail(email: String, pass: String) -> AnyPublisher<AppUser, Error> {
        return authenticationService.signInWithEmail(email: email, pass: pass)
    }

    func signUpWithEmail(email: String, pass: String) -> AnyPublisher<AppUser, Error> {
        return authenticationService.convertToPermanentAccount(with: email, pass: pass)
    }

    func signOut() -> AnyPublisher<Void, Error> {
        return authenticationService.signOut()
    }
}
