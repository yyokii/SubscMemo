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
    var planID: String?
    var planName: String
    var price: Int
    var priceText: String

    static func makeEmptyData() -> SubscPlanViewData {
        return  SubscPlanViewData(
            cycle: "",
            planName: "",
            price: 0,
            priceText: ""
        )
    }

    static func translate(from input: ExploreSubscItem.SubscPlan) -> Self {
        let paymentCycle = PaymentCycle(rawValue: input.cycle)?.title ?? ""

        return SubscPlanViewData(
            cycle: paymentCycle,
            planID: input.planID,
            planName: input.name,
            price: input.price,
            priceText: input.price
                .modifyToPriceStringData()
        )
    }

    static func translate(from input: SubscribedItemJoinedData) -> Self {
        let paymentCycle = PaymentCycle(rawValue: input.cycle)?.title ?? ""

        return SubscPlanViewData(
            cycle: paymentCycle,
            planID: input.planID,
            planName: input.name,
            price: input.price,
            priceText: input.price
                .modifyToPriceStringData()
        )
    }
}

#if DEBUG

let demoSubscPlanViewDatas = [
    SubscPlanViewData(
        cycle: "月々",
        planID: "planID-01",
        planName: "スタンダードプラン",
        price: 1000,
        priceText: "¥1200"
    ),
    SubscPlanViewData(
        cycle: "月々",
        planID: "planID-02",
        planName: "ゴールドプラン",
        price: 2000,
        priceText: "¥1300"
    ),
    SubscPlanViewData(
        cycle: "月々",
        planID: "planID-03",
        planName: "プラチナプラン",
        price: 3000,
        priceText: "¥10200"
    )
]

#endif
