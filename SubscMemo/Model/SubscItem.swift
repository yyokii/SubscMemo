//
//  SubscItem.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/10.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct SubscItem: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var price: Int
    var cycle: String
    var payAt: Timestamp?
    var plan: String
    var category: String
    var url: String
    var description: String
    @ServerTimestamp var createdTime: Timestamp?

    static func makeNewItem() -> SubscItem {
        return SubscItem(title: "", price: 0, cycle: "monthly", payAt: nil, plan: "", category: "", url: "", description: "")
    }
}

#if DEBUG
let testDataTasks = [
    SubscItem(title: "demo-01", price: 100, cycle: "monthly", payAt: nil, plan: "", category: "", url: "", description: ""),
    SubscItem(title: "demo-02", price: 200, cycle: "monthly", payAt: nil, plan: "", category: "", url: "", description: "")
]
#endif
