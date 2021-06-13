//
//  SubscribedItemJoinedData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/14.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

/// ユーザーが登録済みのサービス情報とその関連情報（カテゴリー情報）を結合したデータ
struct SubscribedItemJoinedData {
    var createdTime: Timestamp?
    var cycle: String
    var description: String
    var id: String?
    var iconImageURL: String?
    var isUserOriginal: Bool // true: ユーザーが独自に追加したもの, false: アプリが提供しているサービス群か追加したもの
    var mainCategoryID: String
    var mainCategoryName: String
    var memo: String
    var name: String
    var planID: String?
    var planName: String?
    var price: Int
    var payAt: Timestamp?
    var subCategoryID: String?
    var subCategoryName: String?
    var serviceID: String
    var serviceURL: String?
}

#if DEBUG
let demoSubscItemJoinedDatas = [
    SubscribedItemJoinedData(
        createdTime: nil,
        cycle: "monthly",
        description: "",
        id: "demo-01",
        iconImageURL: "https://via.placeholder.com/150",
        isUserOriginal: false,
        mainCategoryID: "",
        mainCategoryName: "demo-category",
        memo: "メモメモメモメモメモメモ",
        name: "demo-name",
        planID: nil,
        planName: nil,
        price: 1000,
        payAt: nil,
        subCategoryID: nil,
        subCategoryName: nil,
        serviceID: "demo-service-id",
        serviceURL: ""
    ),
    SubscribedItemJoinedData(
        createdTime: nil,
        cycle: "monthly",
        description: "",
        id: "demo-01",
        iconImageURL: "https://via.placeholder.com/150",
        isUserOriginal: false,
        mainCategoryID: "",
        mainCategoryName: "demo-category",
        memo: "メモメモメモメモメモメモ",
        name: "demo-name",
        planID: nil,
        planName: nil,
        price: 1000,
        payAt: nil,
        subCategoryID: nil,
        subCategoryName: nil,
        serviceID: "demo-service-id",
        serviceURL: ""
    )
]
#endif