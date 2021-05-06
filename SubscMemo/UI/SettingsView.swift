//
//  SettingsView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/01.
//

import SwiftUI

struct SettingsView: View {
    @State var notificationsEnabled: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("プッシュ通知")) {
                    SettingsRow(title: "通知オン/オフ") {
                        Toggle(isOn: $notificationsEnabled) {
                        }
                    }
                }

                Section(header: Text("アプリについて")) {

                    SettingsRow(title: "バージョン") {
                        Text("2.2.1")
                    }
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

/// 設定画面の各項目。タイトルと、特定のviewを表示します。
public struct SettingsRow<Content>: View where Content: View {

    let title: String
    let content: () -> Content

    public init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    public var body: some View {
        HStack {
            Text(title)
            Spacer()
            content()
        }
        .adaptiveFont(.matterMedium, size: 12)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            SettingsView()
                .environment(\.colorScheme, .light)

            SettingsView()
                .environment(\.colorScheme, .dark)
        }
    }
}