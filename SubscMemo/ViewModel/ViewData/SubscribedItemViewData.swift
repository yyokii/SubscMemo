//
//  SubscribedItemViewData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/29.
//

struct SubscribedItemViewData {
    var cycle: String
    var mainCategoryName: String
    var planName: String?
    var price: String
    var serviceID: String
    var serviceName: String
    var serviceURL: String?

    static func translate(from input: SubscribedItemJoinedData) -> Self {
        let paymentCycle = PaymentCycle.init(rawValue: input.cycle)

        #warning("mainCategoryの取得を修正")
        return SubscribedItemViewData(
            cycle: paymentCycle?.title ?? "",
            mainCategoryName: input.categoryNames[safe: 0] ?? "",
            planName: input.planName,
            price: input.price.modifyToPriceStringData(),
            serviceID: input.serviceID,
            serviceName: input.name,
            serviceURL: input.serviceURL
        )
    }
}
