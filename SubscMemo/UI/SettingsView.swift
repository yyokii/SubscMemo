//
//  SettingsView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/01.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var vm = SettingsViewModel()
    @State var presentContent: PresentContent?

    var body: some View {
        Form {
            Section(header: Text("ユーザー情報")) {
                SettingsRow(title: "ユーザーステータス") {
                    Text(vm.appUser.status.statusName)
                }

                SettingsRow(title: "") {
                    Button("ログインする") {
                        presentContent = .loginAndSignUp
                    }
                }
            }

            Section(header: Text("アプリについて")) {
                SettingsRow(title: "バージョン") {
                    Text(vm.appVersion)
                }
            }
        }
        .navigationBarTitle("アプリ設定")
        .sheet(item: $presentContent, content: { $0 })
    }

    private func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
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

#if DEBUG

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

#endif
