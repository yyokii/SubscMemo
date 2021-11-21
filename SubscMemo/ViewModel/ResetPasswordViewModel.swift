//
//  ResetPasswordViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/11/11.
//

import Combine

import Resolver

final class ResetPasswordViewModel: ObservableObject {

    @Published var email: String = ""
    @Published var message: String = ""

    private var sendButtonPublisher = PassthroughSubject<Bool, Never>()
    var tappedButton = false {
        didSet {
            sendButtonPublisher.send(tappedButton)
        }
    }

    // Dialog Manager
    @Published var alertProvider = AlertProvider()

    // Repository
    @Injected var userProfileRepository: UserProfileRepository

    private var cancellables = Set<AnyCancellable>()

    init() {

        #if DEBUG
        email = "yyokii.h@gmail.com"
        #endif

        sendButtonPublisher
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .filter { $0 }
            .filter { [weak self] _ in
                !(self?.email.isEmpty ?? true)
            }
            .compactMap { [weak self] _ in
                self?.userProfileRepository.resetPassword(email: self?.email ?? "")
            }
            .flatMap { $0 }
            .sink(receiveCompletion: { [weak self] completion in

                self?.message = ""
                switch completion {
                case .failure:
                    self?.alertProvider.showErrorAlert(message: nil)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] in
                self?.message = "✅ 送信しました"
            })
            .store(in: &cancellables)
    }
}

#if DEBUG

var demoResetPasswordVM: ResetPasswordViewModel {
    let vm = ResetPasswordViewModel()
    return vm
}

#endif
