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
    var categoryIDs: [String]
    @ServerTimestamp var createdTime: Timestamp?
    var description: String
    @DocumentID var id: String?
    var name: String
    var serviceID: String
    var serviceURL: String

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
        categoryIDs: ["demo-id"],
        createdTime: nil,
        description: "demo-description",
        id: "demo-id",
        name: "demo-name01",
        serviceID: "demo-serviceID",
        serviceURL: "https://www.google.com/?hl=ja"
    ),
    ExploreSubscItem(
        categoryIDs: ["demo-id"],
        createdTime: nil,
        description: "demo-description",
        id: "demo-id",
        name: "demo-name02",
        serviceID: "demo-serviceID",
        serviceURL: "https://www.google.com/?hl=ja"
    )
]
#endif
