//
//  SubscribedItemViewData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/29.
//

struct SubscribedItemViewData {

    let subscribedItemJoinedData: SubscribedItemJoinedData

    init(data: SubscribedItemJoinedData) {
        subscribedItemJoinedData = data
    }

    var serviceName: String {
        return subscribedItemJoinedData.name
    }

    var planName: String? {
        return subscribedItemJoinedData.planName
    }

    var price: String {
        return subscribedItemJoinedData.price.modifyToPriceStringData()
    }

    var imageURL: String? {
        return subscribedItemJoinedData.iconImageURL
    }

    var payAtDate: String? {
        let dateString = subscribedItemJoinedData.payAt?
            .dateValue()
            .toString(format: .yMd, timeZone: .japan)
        return dateString
    }

    var cycle: String {
        let paymentCycle = PaymentCycle(rawValue: subscribedItemJoinedData.cycle)?.title ?? ""
        return paymentCycle
    }
}
