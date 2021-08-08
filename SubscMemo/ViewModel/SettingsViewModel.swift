//
//  SettingsViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/07.
//

import Combine

final class SettingsViewModel: ObservableObject, Identifiable {

    @Published var appVersion: String

    init() {
        let version = AppVersion.current
        appVersion = version.productVersion
    }
}

#if DEBUG

var demoSettingsViewModel: SettingsViewModel {
    let vm = SettingsViewModel()
    return vm
}

#endif
