//
//  LoginAndSignUpViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/16.
//

import Combine

final class LoginAndSignUpViewModel: ObservableObject {

    @Published var userProfileRepository: UserProfileRepository = FirestoreUserProfileRepository()

    @Published var name: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        userProfileRepository.$appUser
            .map { user in

                switch user?.status {
                case .uninitialized:
                    return ""
                case .authenticated:
                    return user?.name ?? ""
                case .authenticatedAnonymously:
                    return "ゲスト"
                case .none:
                    return ""
                }
            }
            .assign(to: \.name, on: self)
            .store(in: &cancellables)
    }
}

#if DEBUG

var loginAndSignUpVM: LoginAndSignUpViewModel {

    let vm = LoginAndSignUpViewModel()
    return vm
}

#endif
