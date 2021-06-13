//
//  SubscItemTextField.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/08.
//

import SwiftUI

struct SubscItemTextField: View {
    var isDisabled = false
    let placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: _text)
            .disabled(isDisabled)
            .multilineTextAlignment(.trailing)
            .adaptiveFont(.matterSemiBold, size: 8)
            .foregroundColor(isDisabled ? .gray : .adaptiveBlack)
            .textFieldStyle(PlainTextFieldStyle())
    }
}

#if DEBUG

struct SubscItemTextField_Previews: PreviewProvider {
    struct ContentView: View {
        var body: some View {
            NavigationView {
                VStack {
                    SubscItemTextField(
                        isDisabled: false,
                        placeholder: "ぷれーすほるだー",
                        text: .constant("demo-text")
                    )

                    SubscItemTextField(
                        isDisabled: true,
                        placeholder: "ぷれーすほるだー",
                        text: .constant("demo-text")
                    )
                }
            }
        }
    }

    static var previews: some View {
        Group {
            ContentView()
                .environment(\.colorScheme, .light)

            ContentView()
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
