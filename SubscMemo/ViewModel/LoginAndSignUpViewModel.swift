//
//  LoginAndSignUpViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/16.
//

import Combine

/// ユーザーがログインする際の認証情報
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

    var alertProvider = AlertProvider()

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

        showAlert()
    }

    func showAlert() {
        alertProvider.alert = AlertProvider.Alert(
            title: "The Locatoin Services are disabled",
            message: "Do you want to turn location on?",
            primaryButtomText: "Go To Settings",
            primaryButtonAction: { [weak self] in

            },
            secondaryButtonText: "Cancel"
        )
    }
}

#if DEBUG

var loginAndSignUpVM: LoginAndSignUpViewModel {

    let vm = LoginAndSignUpViewModel()
    return vm
}

#endif
