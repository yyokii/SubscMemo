//
//  LoginAndSignUpViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/16.
//

import Combine
import Dispatch

import Resolver

/// ユーザーがログインする際の認証情報
struct UserLoginAuthData {
    var email = ""
    var password = ""
}

final class LoginAndSignUpViewModel: ObservableObject {

    // Repository
    @Published var userProfileRepository: UserProfileRepository = Resolver.resolve()

    // Validation
    @Published var emailValidationVM = ValidationStateViewModel()
    @Published var passwordValidationVM = ValidationStateViewModel()

    // Manage View Presentation
    var dismissViewPublisher = PassthroughSubject<Bool, Never>()
    private var shouldDismissView = false {
        didSet {
            dismissViewPublisher.send(shouldDismissView)
        }
    }

    @Published var alertProvider = AlertProvider()
    @Published var canLogin: Bool = false
    @Published var canSignUp: Bool = false
    @Published var dismiss: Bool = false
    @Published var userLoginAuthData: UserLoginAuthData = UserLoginAuthData()
    @Published var validLoginEmail: Bool?
    @Published var validLoginPass: Bool = false
    @Published var validSignUpEmail: Bool = false
    @Published var validSignUpPass: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {

        // https://stackoverflow.com/questions/58406287/how-to-tell-swiftui-views-to-bind-to-nested-observableobjects
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

var demoLoginAndSignUpVM: LoginAndSignUpViewModel {

    let vm = LoginAndSignUpViewModel()
    return vm
}

#endif
