//
//  SettingsViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/07.
//

import Combine

import Resolver

final class SettingsViewModel: ObservableObject, Identifiable {

    // Dialog Manager
    @Published var alertProvider = AlertProvider()

    // Repository
    @Injected var userProfileRepository: UserProfileRepository

    @Published var appVersion: String
    @Published var appUser: AppUser!

    private var cancellables = Set<AnyCancellable>()

    init() {
        let version = AppVersion.current
        appVersion = version.productVersion

        alertProvider.objectWillChange
            .sink { [weak self] (_) in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)

        userProfileRepository.$appUser
            .assign(to: \.appUser, on: self)
            .store(in: &cancellables)
    }
}

#if DEBUG

var demoSettingsViewModel: SettingsViewModel {
    let vm = SettingsViewModel()
    return vm
}

#endif
