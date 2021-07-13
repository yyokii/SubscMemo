//
//  ExploreItemJoinedData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/07.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

/// アプリが提供しているサービス群の任意のものの情報とその関連情報（カテゴリー情報）を結合したデータ
struct ExploreItemJoinedData {
    var categoryIDs: [String]
    var categoryNames: [String]
    var createdTime: Timestamp?
    var description: String
    var id: String?
    var iconImageURL: String?
    var name: String
    var serviceID: String
    var serviceURL: String?
}

#if DEBUG
let demoExploreItemJoinedDatas = [
    ExploreItemJoinedData(
        categoryIDs: ["demo-id"],
        categoryNames: ["demo-name"],
        createdTime: nil,
        description: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        id: "demo-01",
        iconImageURL: "https://via.placeholder.com/150",
        name: "demo-name",
        serviceID: "demo-service-id",
        serviceURL: ""
    ),
    ExploreItemJoinedData(
        categoryIDs: ["demo-id"],
        categoryNames: ["demo-name"],
        createdTime: nil,
        description: "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
        id: "demo-01",
        iconImageURL: "https://via.placeholder.com/150",
        name: "demo-name",
        serviceID: "demo-service-id",
        serviceURL: ""
    )
]
#endif
