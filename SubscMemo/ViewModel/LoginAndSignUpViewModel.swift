//
//  LoginAndSignUpViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/16.
//

import Combine
import Dispatch

/// ユーザーがログインする際の認証情報
struct UserLoginAuthData {
    var email = ""
    var password = ""
}

final class LoginAndSignUpViewModel: ObservableObject {

    @Published var userProfileRepository: UserProfileRepository = FirestoreUserProfileRepository()

    @Published var emailValidationVM = ValidationStateViewModel()
    @Published var passwordValidationVM = ValidationStateViewModel()

    @Published var userLoginAuthData: UserLoginAuthData = UserLoginAuthData()

    var viewDismissalModePublisher = PassthroughSubject<Bool, Never>()
    private var shouldDismissView = false {
        didSet {
            viewDismissalModePublisher.send(shouldDismissView)
        }
    }

    @Published var canLogin: Bool = false
    @Published var canSignUp: Bool = false
    @Published var dismiss: Bool = false
    @Published var validLoginEmail: Bool?
    @Published var validLoginPass: Bool = false
    @Published var validSignUpEmail: Bool = false
    @Published var validSignUpPass: Bool = false

    @Published var isPresentAlert: Bool = false

    @Published var alertProvider = AlertProvider()

    private var cancellables = Set<AnyCancellable>()

    init() {

        alertProvider.objectWillChange
            .sink { [weak self] (_) in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)

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

                if let emailValidationResult = self?.emailValidationVM.state,
                   let passValidationResult = self?.passwordValidationVM.state,
                   case .valid = emailValidationResult,
                   case .valid = passValidationResult {

                    self?.canLogin = true
                    self?.canSignUp = true

                } else {

                    self?.canLogin = false
                    self?.canSignUp = false
                }
            }
            .store(in: &cancellables)
    }

    func showAlert() {

        alertProvider.alert = AlertProvider.Alert(
            title: "demo",
            message: "demo-message",
            primaryButtomText: "OK",
            primaryButtonAction: {},
            secondaryButtonText: ""
        )
    }

    func login() {

        userProfileRepository.loginWithEmail(email: userLoginAuthData.email, pass: userLoginAuthData.password)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in

                switch completion {
                case .failure(let error):

                    self?.alertProvider.alert = AlertProvider.Alert(
                        title: "エラー",
                        message: error.localizedDescription,
                        primaryButtomText: "OK",
                        primaryButtonAction: {},
                        secondaryButtonText: ""
                    )

                // self?.showAlert()

                case .finished:
                    break
                }

            }, receiveValue: { _ in
                self.shouldDismissView = true
            })
            .store(in: &cancellables)
    }

    func signUpWithEmail() {

        userProfileRepository.signUpWithEmail(email: userLoginAuthData.email, pass: userLoginAuthData.password)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in

                switch completion {
                case .failure(let error):

                    self?.alertProvider.alert = AlertProvider.Alert(
                        title: "エラー",
                        message: error.localizedDescription,
                        primaryButtomText: "OK",
                        primaryButtonAction: {},
                        secondaryButtonText: ""
                    )

                case .finished:
                    break
                }

            }, receiveValue: { _ in
                self.shouldDismissView = true
            })
            .store(in: &cancellables)
    }
}

#if DEBUG

var loginAndSignUpVM: LoginAndSignUpViewModel {

    let vm = LoginAndSignUpViewModel()
    return vm
}

#endif
