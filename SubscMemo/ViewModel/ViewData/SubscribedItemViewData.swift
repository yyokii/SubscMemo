//
//  SubscribedItemViewData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/29.
//

struct SubscribedItemViewData {
    var cycle: String
    let id: String
    var mainCategoryName: String
    var planName: String?
    var price: String
    var serviceID: String
    var serviceName: String
    var serviceURL: String?

    static func translate(from input: SubscribedItemJoinedData) -> Self {
        let paymentCycle = PaymentCycle.init(rawValue: input.cycle)

        return SubscribedItemViewData(
            cycle: paymentCycle?.title ?? "",
            id: input.id!,
            mainCategoryName: input.categoryNames[safe: 0] ?? "",
            planName: input.planName,
            price: input.price.modifyToPriceStringData(),
            serviceID: input.serviceID,
            serviceName: input.name,
            serviceURL: input.serviceURL
        )
    }
}
