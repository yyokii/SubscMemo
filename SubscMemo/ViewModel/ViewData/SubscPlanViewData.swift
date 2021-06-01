//
//  SubscPlanViewData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/30.
//

import Foundation

struct SubscPlanViewData: Identifiable {
    var cycle: String
    var id = UUID()
    var planName: String
    var price: String

    static func translate(from input: ExploreSubscItem.SubscPlan) -> Self {

        let paymentCycle = PaymentCycle(rawValue: input.cycle)?.title ?? ""

        return SubscPlanViewData(
            cycle: paymentCycle,
            planName: input.name,
            price: input.price
                .modifyToPriceStringData()
        )
    }
}

#if DEBUG

let demoSubscPlanViewDatas = [
    SubscPlanViewData(
        cycle: "月々",
        planName: "スタンダードプラン",
        price: "¥1200"
    ),
    SubscPlanViewData(
        cycle: "月々",
        planName: "ゴールドプラン",
        price: "¥1300"
    ),
    SubscPlanViewData(
        cycle: "月々",
        planName: "プラチナプラン",
        price: "¥10200"
    )
]

#endif
