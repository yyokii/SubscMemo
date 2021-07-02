//
//  ExploreSubscItemDetailViewData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/06.
//

import Foundation

// サブスクリプションサービスの詳細画面で表示する基本情報
struct ExploreSubscItemDetailViewData {
    var description: String
    var iconImageURL: String?
    var mainCategoryName: String
    var serviceName: String
    var serviceURL: URL?
    var subCategoryName: String?

    static func makeEmptyData() -> Self {
        return  ExploreSubscItemDetailViewData(
            description: "",
            iconImageURL: nil,
            mainCategoryName: "",
            serviceName: "",
            serviceURL: nil,
            subCategoryName: nil
        )
    }

    static func translate(from input: ExploreItemJoinedData) -> Self {
        let url = URL(string: input.serviceURL ?? "")

        return ExploreSubscItemDetailViewData(
            description: input.description,
            iconImageURL: input.iconImageURL,
            mainCategoryName: input.categoryNames[0],
            serviceName: input.name,
            serviceURL: url,
            subCategoryName: input.categoryNames[safe: 1]
        )
    }
}

#if DEBUG

let demoExploreSubscItemDetailViewData = ExploreSubscItemDetailViewData(
    description: "せつめいせつめいせつめいせつめいせつめいせつめいせつめいせつめいせつめいせつめいせつめい",
    iconImageURL: nil,
    mainCategoryName: "ソーシャルネットワーキング",
    serviceName: "サービス名",
    serviceURL: nil,
    subCategoryName: nil
)

#endif
