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
        VStack {
            ForEach(plans) { plan in
                SubscPlanItemView(
                    planName: plan.planName,
                    price: plan.price,
                    cycle: plan.cycle
                )
                .padding(8)
            }
        }
        .background(Color.adaptiveWhite)
    }
}

struct SubscPlanItemView: View {
    var planName: String
    var price: String
    var cycle: String

    var body: some View {
        HStack {
            Text(planName)
                .adaptiveFont(.matterSemiBold, size: 16)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(3)
                .foregroundColor(.adaptiveBlack)

            Spacer()

            Text(price)
                .adaptiveFont(.matterSemiBold, size: 22)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .foregroundColor(.adaptiveBlack)

            Text("/" + cycle)
                .adaptiveFont(.matterSemiBold, size: 16)
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
