//
//  Bundle+VersionData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/07.
//

import Foundation

struct AppVersion {
    let productVersion: String
    let buildNumber: String

    static let current = AppVersion(
        productVersion: Bundle.main.cfBundleShortVersionString,
        buildNumber: Bundle.main.cfBundleVersion
    )
}

private extension Bundle {
    var cfBundleShortVersionString: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    var cfBundleVersion: String {
        infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
}
