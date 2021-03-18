//
//  AuthenticationService.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/11.
//

import FirebaseAuth

protocol BaseAuthenticationService {
    func convertToPermanentAccount(with email: String, pass: String)
    func signInAnonymously()
    func signInWithEmail(email: String, pass: String)
    func signOut()
}

final class AuthenticationService: BaseAuthenticationService {

    @Published var user: AppUser!

    private var handle: AuthStateDidChangeListenerHandle?

    init() {
        registerStateListener()
    }

    func convertToPermanentAccount(with email: String, pass: String) {
        let credential = EmailAuthProvider.credential(withEmail: email, password: pass)

        let user = Auth.auth().currentUser
        user?.link(with: credential) { (_, error) in

            if let error = error {
                #warning("エラー処理")
            }
        }
    }

    func signInAnonymously() {

        let user: User? = Auth.auth().currentUser
        let appUser = AppUser(from: user)

        switch appUser.status {
        case .uninitialized:
            Auth.auth().signInAnonymously { (_, error) in

                if let error = error {
                    #warning("エラー処理")
                }
            }
        case .authenticatedAnonymously, .authenticated:
            break
        }
    }

    func signInWithEmail(email: String, pass: String) {
        Auth.auth().signIn(withEmail: email, password: pass) { (_, error) in

            if let error = error {
                #warning("エラー処理")
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            #warning("エラー処理")
        }
    }

    private func registerStateListener() {

        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }

        self.handle = Auth.auth().addStateDidChangeListener { [weak self] (_, user) in

            self?.user = AppUser(from: user)

            if let user = user {
                let anonymous = user.isAnonymous ? "anonymously " : ""
                print("User signed in \(anonymous)with user ID \(user.uid). Email: \(user.email ?? "(empty)"), display name: [\(user.displayName ?? "(empty)")]")
            } else {
                print("User signed out.")
                self?.signInAnonymously()
            }
        }
    }

}
