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
    var categoryIDs: [String]
    var categoryNames: [String]
    var createdTime: Timestamp?
    var cycle: String
    var description: String
    var id: String?
    var isUserOriginal: Bool // true: ユーザーが独自に追加したもの, false: アプリが提供しているサービス群か追加したもの
    var memo: String
    var name: String
    var planID: String?
    var planName: String?
    var price: Int
    var payAt: Timestamp?
    var serviceID: String
    var serviceURL: String?
}

#if DEBUG
let demoSubscItemJoinedDatas = [
    SubscribedItemJoinedData(
        categoryIDs: ["demo-id"],
        categoryNames: ["demo-name"],
        createdTime: nil,
        cycle: "monthly",
        description: "",
        id: "demo-01",
        isUserOriginal: false,
        memo: "メモメモメモメモメモメモ",
        name: "demo-name",
        planID: nil,
        planName: nil,
        price: 1000,
        payAt: nil,
        serviceID: "demo-service-id",
        serviceURL: ""
    ),
    SubscribedItemJoinedData(
        categoryIDs: ["demo-id"],
        categoryNames: ["demo-name"],
        createdTime: nil,
        cycle: "monthly",
        description: "",
        id: "demo-01",
        isUserOriginal: false,
        memo: "メモメモメモメモメモメモ",
        name: "demo-name",
        planID: nil,
        planName: nil,
        price: 1000,
        payAt: nil,
        serviceID: "demo-service-id",
        serviceURL: ""
    )
]
#endif
