//
//  PaymentCyclePickerView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/22.
//

import SwiftUI

struct PaymentCyclePickerView: View {

    @Binding var selectedCycle: String

    var body: some View {
        VStack {
            Picker("支払いサイクル", selection: $selectedCycle) {
                ForEach(PaymentCycle.allCases) { cycle in
                    Text(cycle.title)
                        .tag(cycle.rawValue)
                        .adaptiveFont(.matterSemiBold, size: 8)
                        .foregroundColor(.adaptiveBlack)
                }
            }
            .adaptiveFont(.matterSemiBold, size: 8)
            .foregroundColor(.placeholderGray)
        }
    }
}

#if DEBUG

struct PaymentCyclePickerView_Previews: PreviewProvider {

    struct ContentView: View {
        var body: some View {
            NavigationView {
                PaymentCyclePickerView(selectedCycle: .constant("demo"))
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
