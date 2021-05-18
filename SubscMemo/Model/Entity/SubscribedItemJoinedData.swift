//
//  SubscribedItemJoinedData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/14.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

/// カテゴリー情報、サービス情報を結合したデータ
struct SubscribedItemJoinedData {
    var createdTime: Timestamp?
    var cycle: String
    var description: String
    var id: String?
    var iconImageURL: String
    var mainCategoryID: String
    var mainCategoryName: String
    var name: String
    var planID: String?
    var planName: String?
    var price: Int
    var payAt: Timestamp?
    var subCategoryID: String?
    var subCategoryName: String?
    var serviceID: String
    var seriviceURL: String
}

#if DEBUG
let demoSubscItemJoinedDatas = [
    SubscribedItemJoinedData(createdTime: nil,
                             cycle: "monthly",
                             description: "",
                             id: "demo-01",
                             iconImageURL: "https://via.placeholder.com/150",
                             mainCategoryID: "",
                             mainCategoryName: "demo-category",
                             name: "demo-name",
                             planID: nil,
                             planName: nil,
                             price: 1000,
                             payAt: nil,
                             subCategoryID: nil,
                             subCategoryName: nil,
                             serviceID: "demo-service-id",
                             seriviceURL: ""),

    SubscribedItemJoinedData(createdTime: nil,
                             cycle: "monthly",
                             description: "",
                             id: "demo-01",
                             iconImageURL: "https://via.placeholder.com/150",
                             mainCategoryID: "",
                             mainCategoryName: "demo-category",
                             name: "demo-name",
                             planID: nil,
                             planName: nil,
                             price: 1000,
                             payAt: nil,
                             subCategoryID: nil,
                             subCategoryName: nil,
                             serviceID: "demo-service-id",
                             seriviceURL: "")
]
#endif
