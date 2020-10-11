//
//  AuthenticationService.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/11.
//

import SwiftUI
import FirebaseAuth

final class AuthenticationService {
  
  func signIn() {
    if Auth.auth().currentUser == nil {
      Auth.auth().signInAnonymously()
    }
  }
}
