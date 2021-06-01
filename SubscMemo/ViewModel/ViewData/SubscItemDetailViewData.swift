//
//  SubscItemDetailViewData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/30.
//

import Foundation

// サブスクリプションサービスの詳細画面で表示する基本情報
struct SubscItemDetailViewData {
    var cycle: String?
    var description: String
    var iconImageURL: String?
    var mainCategoryName: String
    var payAtDate: String?
    var planName: String?
    var price: String?
    var serviceName: String
    var serviceURL: URL?
    var subCategoryName: String?

    static func translate(from input: SubscribedItemJoinedData) -> Self {
        let url = URL(string: input.serviceURL ?? "")

        return SubscItemDetailViewData(
            cycle: nil,
            description: input.description,
            iconImageURL: input.iconImageURL,
            mainCategoryName: "",
            payAtDate: nil,
            planName: nil,
            price: nil,
            serviceName: input.name,
            serviceURL: url,
            subCategoryName: ""
        )
    }

    static func translate(from input: ExploreSubscItem) -> Self {
        let url = URL(string: input.serviceURL ?? "")

        return SubscItemDetailViewData(
            cycle: nil,
            description: input.description,
            iconImageURL: input.iconImageURL,
            mainCategoryName: "",
            payAtDate: nil,
            planName: nil,
            price: nil,
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
    mainCategoryName: "ソーシャルネットワーキング",
    payAtDate: "2020/10/10",
    planName: "スタンダードプラン",
    price: "¥1200",
    serviceName: "サービス名",
    serviceURL: nil,
    subCategoryName: nil
)

#endif
