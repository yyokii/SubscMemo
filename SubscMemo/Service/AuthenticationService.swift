//
//  AuthenticationService.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/11.
//

import FirebaseAuth

final class AuthenticationService {

    @Published var user: AppUser!

    func signIn() {

        let user: User? = Auth.auth().currentUser
        let appUser = AppUser(from: user)

        switch appUser.status {
        case .uninitialized:
            Auth.auth().signInAnonymously { (result, error) in
                if error == nil {
                    self.user = AppUser(from: result?.user)
                } else {
                    #warning("エラー処理")
                }
            }
        case .authenticatedAnonymously, .authenticated:
            self.user = appUser
        }
    }
}
