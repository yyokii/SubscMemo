//
//  SubscItemDetailViewData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/30.
//

import Foundation

// サブスクリプションサービスの詳細画面で表示する基本情報
struct SubscItemDetailViewData {
    var cycle: String
    var description: String
    var iconImageURL: String?
    var isUserOriginal: Bool
    var mainCategoryName: String
    var memo: String = ""
    var payAtDate: String?
    var planID: String?
    var planName: String?
    var price: String
    var serviceName: String
    var serviceURL: URL?
    var subCategoryName: String?

    static func makeEmptyData() -> SubscItemDetailViewData {
        return  SubscItemDetailViewData(
            cycle: "",
            description: "",
            iconImageURL: nil,
            isUserOriginal: true,
            mainCategoryName: "",
            payAtDate: nil,
            planID: nil,
            planName: nil,
            price: "",
            serviceName: "",
            serviceURL: nil,
            subCategoryName: nil
        )
    }

    static func translate(from input: SubscribedItemJoinedData) -> Self {
        let url = URL(string: input.serviceURL ?? "")
        let paymentCycle = PaymentCycle.init(rawValue: input.cycle)
        let payAtDate = input.payAt?.dateValue().toString(format: .yMd, timeZone: .japan) ?? "設定されていません"

        return SubscItemDetailViewData(
            cycle: paymentCycle?.title ?? "",
            description: input.description,
            iconImageURL: input.iconImageURL,
            isUserOriginal: input.isUserOriginal,
            mainCategoryName: input.mainCategoryName,
            memo: input.memo,
            payAtDate: payAtDate,
            planID: input.planID,
            planName: input.planName,
            price: input.price.modifyToPriceStringData(),
            serviceName: input.name,
            serviceURL: url,
            subCategoryName: ""
        )
    }
}

#if DEBUG

let demoSubscItemDetailViewData = SubscItemDetailViewData(
    cycle: "月々",
    description: "せつめいせつめいせつめいせつめいせつめいせつめいせつめいせつめいせつめいせつめいせつめい",
    iconImageURL: nil,
    isUserOriginal: true,
    mainCategoryName: "ソーシャルネットワーキング",
    payAtDate: "2020/10/10",
    planName: "スタンダードプラン",
    price: "¥1200",
    serviceName: "サービス名",
    serviceURL: nil,
    subCategoryName: nil
)

#endif
