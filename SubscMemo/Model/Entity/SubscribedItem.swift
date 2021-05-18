//
//  SubscribedItem.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/10.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

// これ消せるのか
/// 登録しているサブスクリプションサービスの情報
struct SubscribedItem: Codable, Identifiable {
    @DocumentID var id: String?
    var cycle: String
    var description: String
    var iconImageURL: String
    var mainCategoryID: String
    var name: String
    var planID: String?
    var planName: String?
    var price: Int
    var payAt: Timestamp?
    var subCategoryID: String?
    var serviceID: String
    var seriviceURL: String
    @ServerTimestamp var createdTime: Timestamp?

    static func makeNewItem() -> SubscribedItem {
        return SubscribedItem(id: nil,
                              cycle: "",
                              description: "",
                              iconImageURL: "https://via.placeholder.com/50",
                              mainCategoryID: "",
                              name: "",
                              planID: nil,
                              planName: "",
                              price: 0,
                              payAt: nil,
                              subCategoryID: "",
                              serviceID: "",
                              seriviceURL: "https://via.placeholder.com/150")
    }
}

#if DEBUG
let demoSubscItems = [
    SubscribedItem(id: "demo-01",
                   cycle: "monthly",
                   description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription",
                   iconImageURL: "https://via.placeholder.com/50",
                   mainCategoryID: "",
                   name: "demo-01",
                   planID: nil,
                   planName: "",
                   price: 100,
                   payAt: nil,
                   subCategoryID: "",
                   serviceID: "",
                   seriviceURL: ""),
    SubscribedItem(id: "demo-02",
                   cycle: "monthly",
                   description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription",
                   iconImageURL: "https://via.placeholder.com/50",
                   mainCategoryID: "",
                   name: "demo-01",
                   planID: nil,
                   planName: "",
                   price: 100,
                   payAt: nil,
                   subCategoryID: "",
                   serviceID: "",
                   seriviceURL: "")
]
#endif