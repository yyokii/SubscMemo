//
//  AppUser.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/11.
//

import Ballcap
import FirebaseFirestore
import FirebaseAuth

final class AppUser: Object, DataRepresentable, DataListenable, HierarchicalStructurable, ObservableObject, Identifiable {

    typealias ID = String

    override class var name: String { "users" }

    struct Model: Codable, Modelable {

        var name: String = ""
        // これいる？
        // var status: UserStatus?
    }

    @Published var data: AppUser.Model?

    enum CollectionKeys: String {
        case subscItems
    }

    var listener: ListenerRegistration?

    func signIn() {
        if Auth.auth().currentUser == nil {

            Auth.auth().signInAnonymously { (authResult, error) in

                if let error = error {
                    // completion(.failure(.serverError(error)))
                } else {
                    guard let user = authResult?.user else {
                        //   completion(.failure(.other(nil)))
                        return
                    }
                    //                    self.user = user
                    //                    completion(.success(AppUser(from: self.user)))
                }
            }
        }
    }
}

enum UserStatus {
    // ユーザー情報が未作成
    case uninitialized
    // ログイン状態
    case authenticated
    // 匿名ログイン状態
    case authenticatedAnonymously
}

//extension AppUser {
//    init(from firebaseUser: User?) {
//
//        if  firebaseUser == nil {
//            // 未認証
//            id = ""
//            name = ""
//            status = .uninitialized
//        } else if firebaseUser!.isAnonymous {
//            // 匿名ログイン
//            id = firebaseUser!.uid
//            name = ""
//            status = .authenticatedAnonymously
//        } else {
//            // ログイン済
//            id = firebaseUser!.uid
//            name = ""
//            status = .authenticated
//        }
//    }
//}
