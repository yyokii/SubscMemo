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

    var body: some View {

        VStack {

            HStack {

                Button(action: {
                    withAnimation(.spring()) {
                        index = 0
                    }
                }, label: {

                    VStack {
                        Text("Login")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(index == 0 ? .black : .gray)

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
                        Text("Sign Up")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(index == 1 ? .black : .gray)

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

    @ObservedObject var loginAndSignUpVM = LoginAndSignUpViewModel()

    var body: some View {

        VStack {

            VStack(alignment: .leading, spacing: 15, content: {

                Text("email")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)

                ValidationStateView(vm: loginAndSignUpVM.emailValidationVM)

                TextField("email", text: $loginAndSignUpVM.userLoginAuthData.email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0.0, y: 5)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0.0, y: -5)

                Text("Password")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)

                ValidationStateView(vm: loginAndSignUpVM.passwordValidationVM)

                TextField("6文字以上", text: $loginAndSignUpVM.userLoginAuthData.password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0.0, y: 5)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0.0, y: -5)

                Button(action: {}, label: {
                    Text("Forget Password")
                        .fontWeight(.bold)
                })
            })
            .padding()

            Button(action: {
                hideKeyboard()
                loginAndSignUpVM.login()
            }, label: {

                Text("Login")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .background(
                        loginAndSignUpVM.canLogin ?
                            LinearGradient(gradient: .init(colors: [Color("accent"), Color("accentShadow")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            : LinearGradient(gradient: .init(colors: [.gray]), startPoint: .topLeading, endPoint: .bottomTrailing)

                    )
                    .cornerRadius(8)
            })
            .padding()
            .disabled(!loginAndSignUpVM.canLogin)
        }
        .alert(isPresented: $loginAndSignUpVM.alertProvider.shouldShowAlert ) {
            guard let alert = loginAndSignUpVM.alertProvider.alert else { fatalError("💔: Alert not available") }
            return Alert(alert)
        }
        .onReceive(loginAndSignUpVM.dismissViewPublisher) { shouldDismiss in
            if shouldDismiss {
                parentPresentationMode.dismiss()
            }
        }
    }
}

struct SignUpView: View {

    @Binding var parentPresentationMode: PresentationMode

    @ObservedObject var loginAndSignUpVM = LoginAndSignUpViewModel()

    var body: some View {

        VStack {

            HStack {

                VStack(alignment: .leading, spacing: 12, content: {

                    Text("Create Account")
                        .font(.title)
                        .fontWeight(.bold)
                })

                Spacer(minLength: 0)
            }
            .padding()

            VStack(alignment: .leading, spacing: 15, content: {

                Text("email")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)

                TextField("email", text: $loginAndSignUpVM.userLoginAuthData.email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0.0, y: 5)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0.0, y: -5)

                Text("Password")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)

                TextField("password", text: $loginAndSignUpVM.userLoginAuthData.password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0.0, y: 5)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0.0, y: -5)
            })
            .padding()

            Button(action: {
                loginAndSignUpVM.signUpWithEmail()
            }, label: {

                Text("Sign Up")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .background(
                        loginAndSignUpVM.canSignUp ?
                            LinearGradient(gradient: .init(colors: [Color("accent"), Color("accentShadow")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            : LinearGradient(gradient: .init(colors: [.gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(8)
            })
            .padding()
            .disabled(!loginAndSignUpVM.canSignUp)
        }
        .alert(isPresented: $loginAndSignUpVM.alertProvider.shouldShowAlert ) {
            guard let alert = loginAndSignUpVM.alertProvider.alert else { fatalError("💔: Alert not available") }
            return Alert(alert)
        }
        .onReceive(loginAndSignUpVM.dismissViewPublisher) { shouldDismiss in
            if shouldDismiss {
                parentPresentationMode.dismiss()
            }
        }
    }
}

#if DEBUG
struct LoginAndSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginAndSignUpView()
        }
    }
}
#endif
