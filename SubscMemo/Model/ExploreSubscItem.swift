//
//  ExploreSubscItem.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/12/15.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct ExploreSubscItem: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var category: String
    var url: String
    var description: String
    @ServerTimestamp var createdTime: Timestamp?

    static func makeNewItem() -> ExploreSubscItem {
        return ExploreSubscItem(title: "", category: "", url: "", description: "")
    }
}

#if DEBUG
let demoExploreSubscItems = [
    ExploreSubscItem(title: "demo-01", category: "category-01", url: "https://www.google.com/?hl=ja", description: "desc-01"),
    ExploreSubscItem(title: "demo-02", category: "category-02", url: "https://www.google.com/?hl=ja", description: "desc-02")
]
#endif
