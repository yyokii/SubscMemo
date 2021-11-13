//
//  ResetPasswordView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/11/11.
//

import SwiftUI

struct ResetPasswordView: View {

    @StateObject var vm = ResetPasswordViewModel()

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 15, content: {
                Text("ご自身のメールアドレスを入力してください\nパスワード変更用のメールが送信されます")
                    .adaptiveFont(.matterMedium, size: 14)

                LoginAndSignUpView.InputTextField(placeholder: "~@aaa.bbb",
                                                  text: $vm.email)
                    .padding(.top)

                Text(vm.message)
                    .adaptiveFont(.matterMedium, size: 14)
            })
            .padding()

            Button("再設定リンクを送信する") {
                vm.tappedButton = true
            }
            .buttonStyle(ActionButtonStyle())
            .padding()
        }
        .alert(isPresented: $vm.alertProvider.shouldShowAlert ) {
            guard let alert = vm.alertProvider.alert else { fatalError("💔: Alert not available") }
            return Alert(alert)
        }
    }
}

#if DEBUG
struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(vm: demoResetPasswordVM)
    }
}
#endif
