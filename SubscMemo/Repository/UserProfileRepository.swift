//
//  UserProfileRepository.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/15.
//

import Combine

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Resolver

class BaseUserProfileRepository {
    @Published var appUser: AppUser!
}

/// ユーザーのプロフィール情報を操作する
protocol UserProfileRepository: BaseUserProfileRepository {
    func signInWithEmail(email: String, pass: String)
    func signOut()
}

final class FirestoreUserProfileRepository: BaseUserProfileRepository, UserProfileRepository, ObservableObject {

    @Injected var authenticationService: AuthenticationService

    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()

        authenticationService.$user
            .assign(to: \.appUser, on: self)
            .store(in: &cancellables)
    }

    func signInWithEmail(email: String, pass: String) {
        authenticationService.convertToPermanentAccount(with: email, pass: pass)
    }

    func signOut() {
        authenticationService.signOut()
    }
}
