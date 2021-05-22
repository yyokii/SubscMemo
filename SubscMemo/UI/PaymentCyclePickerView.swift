//
//  PaymentCyclePickerView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/22.
//

import SwiftUI

enum PaymentCycle: String, CaseIterable, Identifiable {
    case daily
    case weekly
    case monthly
    case every3months = "every_3_months"
    case every6months = "every_6_months"
    case yearly

    var id: String { self.rawValue }
}

struct PaymentCyclePickerView: View {

    @State private var selectedCycle = PaymentCycle.monthly

    var body: some View {
        Picker("支払い頻度", selection: $selectedCycle) {
            ForEach(PaymentCycle.allCases, id: \.self) { cycle in
                Text(cycle.rawValue.capitalized)
                    .adaptiveFont(.matterSemiBold, size: 8)
                    .foregroundColor(.adaptiveBlack)
            }
        }
        .adaptiveFont(.matterSemiBold, size: 8)
        .foregroundColor(.placeholderGray)
    }
}

#if DEBUG

struct PaymentCyclePickerView_Previews: PreviewProvider {

    struct ContentView: View {
        var body: some View {
            NavigationView {
                PaymentCyclePickerView()
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
