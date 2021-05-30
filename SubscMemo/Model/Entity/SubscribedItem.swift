//
//  SubscribedItem.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/10.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

/// 登録しているサブスクリプションサービスの情報
struct SubscribedItem: Codable, Identifiable {
    @DocumentID var id: String?
    var cycle: String
    var description: String
    var iconImageURL: String
    var isUserOriginal: Bool // true: ユーザーが独自に追加したもの, false: アプリが提供しているサービス群か追加したもの
    var mainCategoryID: String
    var name: String
    var planID: String?
    var planName: String?
    var price: Int
    var payAt: Timestamp?
    var subCategoryID: String?
    var serviceID: String
    var serviceURL: String?
    @ServerTimestamp var createdTime: Timestamp?

    static func makeNewItem() -> SubscribedItem {
        return SubscribedItem(id: nil,
                              cycle: "",
                              description: "",
                              iconImageURL: "https://via.placeholder.com/50",
                              isUserOriginal: false,
                              mainCategoryID: "",
                              name: "",
                              planID: nil,
                              planName: "",
                              price: 0,
                              payAt: nil,
                              subCategoryID: "",
                              serviceID: "",
                              serviceURL: "https://via.placeholder.com/150")
    }
}

#if DEBUG
let demoSubscItems = [
    SubscribedItem(id: "demo-01",
                   cycle: "monthly",
                   description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription",
                   iconImageURL: "https://via.placeholder.com/50",
                   isUserOriginal: false,
                   mainCategoryID: "",
                   name: "demo-01",
                   planID: nil,
                   planName: "",
                   price: 100,
                   payAt: nil,
                   subCategoryID: "",
                   serviceID: "",
                   serviceURL: ""),
    SubscribedItem(id: "demo-02",
                   cycle: "monthly",
                   description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription",
                   iconImageURL: "https://via.placeholder.com/50",
                   isUserOriginal: false,
                   mainCategoryID: "",
                   name: "demo-01",
                   planID: nil,
                   planName: "",
                   price: 100,
                   payAt: nil,
                   subCategoryID: "",
                   serviceID: "",
                   serviceURL: "")
]
#endif
