//
//  ExploreSubscItem.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/12/15.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

/// サブスクリプションサービスの情報
struct ExploreSubscItem: Codable, Identifiable {
    var description: String
    var iconImageURL: String
    @DocumentID var id: String?
    var mainCategoryID: String
    var serviceID: String
    var serviceURL: String
    var subCategoryID: String?
    var name: String

    @ServerTimestamp var createdTime: Timestamp?

    struct SubscPlan: Codable {
        var planID: String
        var name: String
        var cycle: String
        var price: Int
    }
}

#if DEBUG
let demoExploreSubscItems = [
    ExploreSubscItem(
        description: "demo-description",
        iconImageURL: "https://via.placeholder.com/150",
        id: "demo-id",
        mainCategoryID: "demo",
        serviceID: "demo-serviceID",
        serviceURL: "https://www.google.com/?hl=ja",
        subCategoryID: "demo",
        name: "demo-name01",
        createdTime: nil
    ),
    ExploreSubscItem(
        description: "demo-description",
        iconImageURL: "https://via.placeholder.com/150",
        id: "demo-id",
        mainCategoryID: "demo",
        serviceID: "demo-serviceID",
        serviceURL: "https://www.google.com/?hl=ja",
        subCategoryID: "demo",
        name: "demo-name02",
        createdTime: nil
    )
]
#endif
