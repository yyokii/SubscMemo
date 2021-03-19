//
//  LoginAndSignUpViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/16.
//

import Combine

final class UserLoginAuthData: ObservableObject {
    var email = ""
    var password = ""
}

final class LoginAndSignUpViewModel: ObservableObject {

    @Published var userProfileRepository: UserProfileRepository = FirestoreUserProfileRepository()

    @Published var emailValidationVM = ValidationStateViewModel()
    @Published var passwordValidationVM = ValidationStateViewModel()

    @Published var userLoginAuthData: UserLoginAuthData = UserLoginAuthData()

    @Published var canLogin: Bool = false
    @Published var canSignUp: Bool = false
    @Published var validLoginEmail: Bool?
    @Published var validLoginPass: Bool = false
    @Published var validSignUpEmail: Bool = false
    @Published var validSignUpPass: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {

        $userLoginAuthData
            .sink { [weak self] data in

                let email = data.email
                let pass = data.password

                if email.isEmpty {
                    self?.emailValidationVM.state = nil
                } else if 1 < email.count && email.count < 100 {
                    self?.emailValidationVM.state = .valid("")
                } else {
                    self?.emailValidationVM.state = .invalid("")
                }

                if pass.isEmpty {
                    self?.passwordValidationVM.state = nil
                } else if 6 < pass.count && pass.count < 100 {
                    self?.passwordValidationVM.state = .valid("")
                } else {
                    self?.passwordValidationVM.state = .invalid("")
                }

            }
            .store(in: &cancellables)
    }
}

#if DEBUG

var loginAndSignUpVM: LoginAndSignUpViewModel {

    let vm = LoginAndSignUpViewModel()
    return vm
}

#endif
