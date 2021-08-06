//
//  PriceTextField.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/05.
//

import SwiftUI

struct PriceTextField: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        HStack {
            Text("¥")
            TextField(placeholder, text: _text)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.adaptiveBlack)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .adaptiveFont(.matterSemiBold, size: 16)
    }
}

#if DEBUG

struct PriceTextField_Previews: PreviewProvider {
    struct ContentView: View {
        var body: some View {
            NavigationView {
                VStack {
                    PriceTextField(
                        placeholder: "ぷれーすほるだー",
                        text: .constant("12000")
                    )

                    PriceTextField(
                        placeholder: "ぷれーすほるだー",
                        text: .constant("12345")
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
