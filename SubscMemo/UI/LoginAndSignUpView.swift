//
//  LoginAndSignUpView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/15.
//

import SwiftUI

struct LoginAndSignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var index = 0

    struct InputTitleView: View {
        let title: String

        var body: some View {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.gray)
        }
    }

    struct InputTextField: View {
        let placeholder: String
        @Binding var text: String

        // ちとvstackとかで囲んで広げよう
        var body: some View {

            VStack {
                TextField(placeholder, text: _text)
                    .multilineTextAlignment(.leading)
                    .adaptiveFont(.matterSemiBold, size: 16)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(16)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
            )

            //            .background(Color.blue)
        }
    }

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation(.spring()) {
                        index = 0
                    }
                }, label: {
                    VStack {
                        Text("ログイン")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(index == 0 ? .adaptiveBlack : .gray)

                        ZStack {
                            Capsule()
                                .fill( index == 0 ? Color.blue : Color.gray)
                                .frame(height: 4)
                        }
                    }
                })

                Button(action: {
                    withAnimation(.spring()) {
                        index = 1
                    }
                }, label: {
                    VStack {
                        Text("新規登録")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(index == 1 ? .adaptiveBlack : .gray)

                        ZStack {
                            Capsule()
                                .fill( index == 1 ? Color.blue : Color.gray)
                                .frame(height: 4)
                        }
                    }
                })
            }
            .padding()

            if index == 0 {
                LoginView(parentPresentationMode: presentationMode)
            } else {
                SignUpView(parentPresentationMode: presentationMode)
            }
        }
    }
}

struct LoginView: View {
    @Binding var parentPresentationMode: PresentationMode
    @StateObject var vm = LoginAndSignUpViewModel()

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 15, content: {
                Text("アカウントをまだお持ちでない場合は\n「新規登録」より作成できます！")

                HStack {
                    LoginAndSignUpView.InputTitleView(title: "メールアドレス")
                    ValidationStateView(vm: vm.emailValidationVM)
                }
                .padding(.top)

                LoginAndSignUpView.InputTextField(placeholder: "~@aaa.bbb",
                                                  text: $vm.userLoginAuthData.email)

                HStack {
                    LoginAndSignUpView.InputTitleView(title: "パスワード")
                    ValidationStateView(vm: vm.passwordValidationVM)
                }
                LoginAndSignUpView.InputTextField(placeholder: "6文字以上",
                                                  text: $vm.userLoginAuthData.password)
            })
            .padding()

            Button("ログイン") {
                vm.login()
            }
            .buttonStyle(ActionButtonStyle())
            .padding()
            .disabled(!vm.canLogin)
        }
        .alert(isPresented: $vm.alertProvider.shouldShowAlert ) {
            guard let alert = vm.alertProvider.alert else { fatalError("💔: Alert not available") }
            return Alert(alert)
        }
        .onReceive(vm.dismissViewPublisher) { shouldDismiss in
            if shouldDismiss {
                parentPresentationMode.dismiss()
            }
        }
    }
}

struct SignUpView: View {
    @Binding var parentPresentationMode: PresentationMode
    @StateObject var vm = LoginAndSignUpViewModel()

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 15, content: {
                HStack {
                    LoginAndSignUpView.InputTitleView(title: "メールアドレス")
                    ValidationStateView(vm: vm.emailValidationVM)
                }
                LoginAndSignUpView.InputTextField(placeholder: "~@aaa.bbb",
                                                  text: $vm.userLoginAuthData.email)

                HStack {
                    LoginAndSignUpView.InputTitleView(title: "パスワード")
                    ValidationStateView(vm: vm.passwordValidationVM)
                }
                LoginAndSignUpView.InputTextField(placeholder: "6文字以上",
                                                  text: $vm.userLoginAuthData.password)
            })
            .padding()

            Button("登録") {
                hideKeyboard()
                vm.signUpWithEmail()
            }
            .buttonStyle(ActionButtonStyle())
            .padding()
            .disabled(!vm.canSignUp)
        }
        .alert(isPresented: $vm.alertProvider.shouldShowAlert ) {
            guard let alert = vm.alertProvider.alert else { fatalError("💔: Alert not available") }
            return Alert(alert)
        }
        .onReceive(vm.dismissViewPublisher) { shouldDismiss in
            if shouldDismiss {
                parentPresentationMode.dismiss()
            }
        }
    }
}

#if DEBUG
struct LoginAndSignUpView_Previews: PreviewProvider {

    static var content: some View {
        NavigationView {
            LoginAndSignUpView()
        }
    }

    static var previews: some View {
        Group {
            content
                .environment(\.colorScheme, .light)

            content
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif
