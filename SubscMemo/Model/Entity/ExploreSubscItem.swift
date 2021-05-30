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
    var category: String
    var description: String
    var iconImageURL: String
    @DocumentID var id: String?
    var serviceURL: String
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

    ExploreSubscItem(category: "category-01", description: "", iconImageURL: "https://via.placeholder.com/150", id: "demo-01", serviceURL: "", name: "demo-name", createdTime: nil),
    ExploreSubscItem(category: "category-01", description: "", iconImageURL: "https://via.placeholder.com/150", id: "demo-01", serviceURL: "", name: "demo-name", createdTime: nil)
]
#endif
