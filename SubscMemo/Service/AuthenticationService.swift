//
//  AuthenticationService.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/11.
//

import Combine

import FirebaseAuth
import CombineFirebaseAuthentication

enum AuthenticationServiceError: Error {
    case other
}

protocol BaseAuthenticationService {
    func convertToPermanentAccount(with email: String, pass: String) -> AnyPublisher<AppUser, Error>
    func setup()
    func signInAnonymously() -> AnyPublisher<Void, Error>
    func signInWithEmail(email: String, pass: String) -> AnyPublisher<AppUser, Error>
    func signOut() -> AnyPublisher<Void, Error>
}

final class AuthenticationService: BaseAuthenticationService {

    @Published var user: AppUser!

    private var handle: AuthStateDidChangeListenerHandle?

    init() {}

    func convertToPermanentAccount(with email: String, pass: String) -> AnyPublisher<AppUser, Error> {

        let credential = EmailAuthProvider.credential(withEmail: email, password: pass)

        if let user = Auth.auth().currentUser {
            return user.link(with: credential).map { result in
                AppUser(id: result.user.uid, name: result.user.displayName ?? "", status: .authenticated)
            }
            .handleEvents(receiveOutput: { appUser in
                self.user = appUser
            })
            .eraseToAnyPublisher()
        } else {
            return Future<AppUser, Error> { promise in
                promise(.failure(AuthenticationServiceError.other))
            }.eraseToAnyPublisher()
        }
    }

    func setup() {
        registerStateListener()
    }

    func signInAnonymously() -> AnyPublisher<Void, Error> {

        let user: User? = Auth.auth().currentUser
        let appUser = AppUser(from: user)

        switch appUser.status {
        case .uninitialized:

            return Auth.auth().signInAnonymously()
                .map({ _ in
                    return ()
                }).eraseToAnyPublisher()

        case .authenticatedAnonymously, .authenticated:
            return Future<Void, Error> { promise in
                promise(.success(()))
            }.eraseToAnyPublisher()
        }
    }

    func signInWithEmail(email: String, pass: String) -> AnyPublisher<AppUser, Error> {

        return Auth.auth().signIn(withEmail: email, password: pass)
            .map { result in
                AppUser(id: result.user.uid, name: result.user.displayName ?? "", status: .authenticated)
            }
            .handleEvents(receiveOutput: { appUser in
                self.user = appUser
            })
            .eraseToAnyPublisher()
    }

    func signOut() -> AnyPublisher<Void, Error> {

        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            return Future<Void, Error> { promise in
                promise(.failure(signOutError))
            }.eraseToAnyPublisher()
        }

        return Future<Void, Error> { promise in
            promise(.success(()))
        }.eraseToAnyPublisher()
    }

    func deleteCurrentUser(email: String, pass: String) {
        let currentUser = Auth.auth().currentUser
        let credential = EmailAuthProvider.credential(withEmail: email, password: pass)

        currentUser?.reauthenticate(with: credential, completion: { _, error in
            if let error = error {
                print("❌ Fail delete user")
                print(error.localizedDescription)
            } else {
                // Delete User
                Auth.auth().currentUser?.delete(completion: { error in
                    if let error = error {
                        print("❌ Fail delete user")
                        print(error.localizedDescription)
                    } else {
                        print("✅ Delete current user")
                    }
                })
            }
        })
    }

    private func registerStateListener() {

        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }

        self.handle = Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            guard let self = self else { return }

            self.user = AppUser(from: user)

            if self.user.status == .uninitialized {
                print("✅ User not signed in.")
                _ = self.signInAnonymously()
            } else {
                print("✅ User signed in.\nUser status:\(self.user.status)\nUser ID: \(self.user.id)\n"
                )
            }
        }
    }

}
