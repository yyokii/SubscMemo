//
//  PresentContent.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/16.
//

import SwiftUI

extension Identifiable where Self: Hashable {
    // swiftlint:disable type_name
    typealias ID = Self
    var id: Self { self }
}

enum PresentContent: View, Hashable, Identifiable {
    case addExploreSubscItem(exploreItemJoinedData: ExploreItemJoinedData, plans: [SubscPlanViewData])
    case createCustomSubscItem
    case loginAndSignUp
    case safariView(url: URL)
    case userSetting

    @ViewBuilder
    var body: some View {
        switch self {
        case .addExploreSubscItem(let exploreItemJoinedData, let plans):
            let vm = AddExploreSubscItemViewModel(exploreItemJoinedData: exploreItemJoinedData, plans: plans)
            AddExploreSubscItemView(vm: vm)
        case .createCustomSubscItem:
            CreateCustomSubscItemView()
        case .loginAndSignUp:
            LoginAndSignUpView()
        case .safariView(let url):
            SafariView(url: url)
        case .userSetting:
            SettingsView()
        }
    }
}
