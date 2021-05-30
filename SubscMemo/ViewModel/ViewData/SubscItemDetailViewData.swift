//
//  SubscItemDetailViewData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/30.
//

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
    var serviceURL: String?
    var subCategoryName: String

    static func translate(from input: SubscribedItemJoinedData) -> Self {
        return SubscItemDetailViewData(
            cycle: nil,
            description: input.description,
            iconImageURL: input.iconImageURL,
            mainCategoryName: "",
            payAtDate: nil,
            planName: nil,
            price: nil,
            serviceName: input.name,
            serviceURL: input.serviceURL,
            subCategoryName: ""
        )
    }

    static func translate(from input: ExploreSubscItem) -> Self {
        return SubscItemDetailViewData(
            cycle: nil,
            description: input.description,
            iconImageURL: input.iconImageURL,
            mainCategoryName: "",
            payAtDate: nil,
            planName: nil,
            price: nil,
            serviceName: input.name,
            serviceURL: input.serviceURL,
            subCategoryName: ""
        )
    }
}
