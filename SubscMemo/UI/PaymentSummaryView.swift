//
//  PaymentSummaryView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/12/27.
//

import SwiftUI

struct PaymentSummaryView: View {
    @StateObject var paymentSummaryVM = PaymentSummaryViewModel()

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.adaptiveWhite)
                .cornerRadius(20)
                .adaptiveShadow()

            VStack {
                PaymentSummaryItemView(title: "月額平均", payment: paymentSummaryVM.monthlyPayment)
                    .padding([.bottom], 10)

                PaymentSummaryItemView(title: "年額平均", payment: paymentSummaryVM.yearlyPayment)
            }
        }
        .frame(height: 160)
    }
}

struct PaymentSummaryItemView: View {
    let title: String
    let payment: Int

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text(title)
                    .adaptiveFont(.matterSemiBold, size: 13)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding([.leading], 10)
            .padding([.bottom], 2)

            Text("¥\(payment)")
                .adaptiveFont(.matterSemiBold, size: 24)
                .padding([.leading], 20)
        }
    }
}

#if DEBUG
struct PaymentSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentSummaryView(paymentSummaryVM: demoPaymentSummaryVM)
    }
}
#endif
