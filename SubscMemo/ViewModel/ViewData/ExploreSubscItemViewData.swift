//
//  ExploreSubscItemViewData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/24.
//

struct ExploreSubscItemViewData {

    var description: String
    var iconImageURL: String?
    var mainCategoryName: String
    var serviceID: String
    var serviceName: String

    static func translate(from input: ExploreItemJoinedData) -> Self {

        return ExploreSubscItemViewData(
            description: input.description,
            iconImageURL: input.iconImageURL,
            mainCategoryName: input.mainCategoryName,
            serviceID: input.serviceID,
            serviceName: input.name
        )
    }

}
