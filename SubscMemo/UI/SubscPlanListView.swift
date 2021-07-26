//
//  SubscPlanListView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/01.
//

import SwiftUI

struct SubscPlanListView: View {
    var plans: [SubscPlanViewData]

    var body: some View {
        VStack(spacing: 10) {
            ForEach(plans) { plan in
                SubscPlanItemView(
                    planName: plan.planName,
                    price: plan.priceText,
                    cycle: plan.cycle?.title ?? ""
                )
            }
        }
        .padding()
        .background(Color.adaptiveWhite)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.adaptiveBlack, lineWidth: 2)
        )

    }
}

struct SubscPlanItemView: View {
    var planName: String
    var price: String
    var cycle: String

    var body: some View {
        HStack {
            Text(planName)
                .adaptiveFont(.matterSemiBold, size: 12)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(3)
                .foregroundColor(.adaptiveBlack)

            Spacer()

            Text(price)
                .adaptiveFont(.matterSemiBold, size: 16)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .foregroundColor(.adaptiveBlack)

            Text("/" + cycle)
                .adaptiveFont(.matterSemiBold, size: 12)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .foregroundColor(.adaptiveBlack)
        }
    }
}

#if DEBUG

struct SubscPlanListView_Previews: PreviewProvider {

    static var content: some View {
        NavigationView {
            SubscPlanListView(plans: demoSubscPlanViewDatas)
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
