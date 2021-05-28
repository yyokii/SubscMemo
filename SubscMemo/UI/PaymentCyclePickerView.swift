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

    var title: String {
        switch self {
        case .daily:
            return "毎日"
        case .weekly:
            return "毎週"
        case .monthly:
            return "毎月"
        case .every3months:
            return "3ヶ月毎"
        case .every6months:
            return "6ヶ月毎"
        case .yearly:
            return "1年毎"
        }
    }
}

struct PaymentCyclePickerView: View {

    @Binding var isPresented: Bool
    @Binding var selectedCycleText: String
    @State private var selectedCycle = PaymentCycle.monthly

    var body: some View {
        VStack {
            Text(selectedCycle.rawValue)
                .adaptiveFont(.matterSemiBold, size: 16)
                .foregroundColor(.adaptiveBlack)
                .padding(.top, 20)

            Picker("設定して下さい", selection: $selectedCycle) {
                ForEach(PaymentCycle.allCases, id: \.self) { cycle in
                    Text(cycle.rawValue.capitalized)
                        .adaptiveFont(.matterSemiBold, size: 8)
                        .foregroundColor(.adaptiveBlack)
                }
            }
            .adaptiveFont(.matterSemiBold, size: 8)
            .foregroundColor(.adaptiveBlack)
            .pickerStyle(InlinePickerStyle())

            Button(action: {
                selectedCycleText = selectedCycle.rawValue
                isPresented = false
            }) {
                Text("閉じる")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.bottom, 20)
            }

        }
        .background(Color.adaptiveWhite)
        .cornerRadius(8)
    }
}

#if DEBUG

struct PaymentCyclePickerView_Previews: PreviewProvider {

    struct ContentView: View {
        var body: some View {
            NavigationView {
                PaymentCyclePickerView(isPresented: .constant(false), selectedCycleText: .constant("demo"))
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
