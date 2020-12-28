//
//  PaymentSummaryView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/12/27.
//

import SwiftUI

struct PaymentSummaryView: View {
    @ObservedObject var paymentSummaryVM = PaymentSummaryViewModel()

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Yearly")
                        .font(.title)
                        .fontWeight(.heavy)

                    Text("¥\(paymentSummaryVM.yearlyPayment)")
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.leading, 60.0)

            HStack {
                VStack(alignment: .leading) {
                    Text("Monthly")
                        .font(.title)
                        .fontWeight(.heavy)

                    Text("¥\(paymentSummaryVM.monthlyPayment)")
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.leading, 60.0)
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
