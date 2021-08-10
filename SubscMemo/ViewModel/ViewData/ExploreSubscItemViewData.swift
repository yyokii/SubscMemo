//
//  ExploreSubscItemViewData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/24.
//

struct ExploreSubscItemViewData {

    var description: String
    var mainCategoryName: String
    var serviceID: String
    var serviceName: String
    var serviceURL: String?

    static func translate(from input: ExploreItemJoinedData) -> Self {

        return ExploreSubscItemViewData(
            description: input.description,
            mainCategoryName: input.categoryNames[safe: 0] ?? "",
            serviceID: input.serviceID,
            serviceName: input.name,
            serviceURL: input.serviceURL
        )
    }

}
