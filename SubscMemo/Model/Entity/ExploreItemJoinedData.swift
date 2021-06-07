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
    var createdTime: Timestamp?
    var description: String
    var id: String?
    var iconImageURL: String?
    var mainCategoryID: String
    var mainCategoryName: String
    var name: String
    var subCategoryID: String?
    var subCategoryName: String?
    var serviceID: String
    var serviceURL: String?
}

#if DEBUG
let demoExploreItemJoinedDatas = [
    ExploreItemJoinedData(
        createdTime: nil,
        description: "",
        id: "demo-01",
        iconImageURL: "https://via.placeholder.com/150",
        mainCategoryID: "",
        mainCategoryName: "demo-category",
        name: "demo-name",
        subCategoryID: nil,
        subCategoryName: nil,
        serviceID: "demo-service-id",
        serviceURL: ""
    ),
    ExploreItemJoinedData(
        createdTime: nil,
        description: "",
        id: "demo-01",
        iconImageURL: "https://via.placeholder.com/150",
        mainCategoryID: "",
        mainCategoryName: "demo-category",
        name: "demo-name",
        subCategoryID: nil,
        subCategoryName: nil,
        serviceID: "demo-service-id",
        serviceURL: ""
    )
]
#endif
