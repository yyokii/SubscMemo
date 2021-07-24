//
//  WidgetSmall.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/07/22.
//

import WidgetKit
import SwiftUI

struct WidgetSmall: View {
    let serviceCount: Int
    let monthlyPayment: Int
    let yearlyPayment: Int

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("登録サービス")
                Spacer()
                Text("\(serviceCount) 個")
            }
            .padding(.horizontal, 8)
            .padding(.top, 8)
            .font(.caption)

            ContainerRelativeShape()
                .fill(Color.yellow)
                .overlay(
                    VStack(spacing: 8) {
                        WidgetPaymentSummaryItemView(title: "月額平均", payment: 10000)

                        WidgetPaymentSummaryItemView(title: "年額平均", payment: 10000)
                    }
                    .padding(.horizontal, 8)
                )
        }
    }
}

struct WidgetPaymentSummaryItemView: View {
    let title: String
    let payment: Int

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text(title)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Spacer()
            }

            Text("¥\(payment)")
                .font(.body)
                .fontWeight(.bold)
        }
    }
}

#if DEBUG

struct WidgetSmall_Previews: PreviewProvider {
    static var previews: some View {
        WidgetSmall(
            serviceCount: 5,
            monthlyPayment: 10000,
            yearlyPayment: 12000
        )
        .previewContext(WidgetPreviewContext(family: .systemSmall))

    }
}

#endif
