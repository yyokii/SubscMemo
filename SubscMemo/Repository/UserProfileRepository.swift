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
    @Published var appUser: AppUser! = AppUser.getUninitializedData()
}

/// ユーザーのプロフィール情報を操作する
protocol UserProfileRepository: BaseUserProfileRepository {
    func loginWithEmail(email: String, pass: String) -> AnyPublisher<AppUser, Error>
    func signUpWithEmail(email: String, pass: String) -> AnyPublisher<AppUser, Error>
    func signOut() -> AnyPublisher<Void, Error>
}

final class FirestoreUserProfileRepository: BaseUserProfileRepository, UserProfileRepository, ObservableObject {

    @Injected var authenticationService: AuthenticationService

    private var cancellables = Set<AnyCancellable>()
    private var db: Firestore = Firestore.firestore()
    private var userId: String = ""

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
    }

    func loginWithEmail(email: String, pass: String) -> AnyPublisher<AppUser, Error> {
        return authenticationService.signInWithEmail(email: email, pass: pass)
            .eraseToAnyPublisher()
    }

    func signUpWithEmail(email: String, pass: String) -> AnyPublisher<AppUser, Error> {
        return authenticationService.convertToPermanentAccount(with: email, pass: pass)
    }

    func signOut() -> AnyPublisher<Void, Error> {
        return authenticationService.signOut()
    }
}
