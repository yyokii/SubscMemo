//
//  SubscPlanViewData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/30.
//

struct SubscPlanViewData {
    var planName: String
    var cycle: String
    var price: String

    static func translate(from input: ExploreSubscItem.SubscPlan) -> Self {

        let paymentCycle = PaymentCycle(rawValue: input.cycle)?.title ?? ""

        return SubscPlanViewData(
            planName: input.name,
            cycle: paymentCycle,
            price: input.price
                .modifyToPriceStringData()
        )
    }
}
