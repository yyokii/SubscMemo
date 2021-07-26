//
//  ExploreItemJoinedData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/07.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

/// アプリが提供しているサービス群の任意のものの情報とその関連情報（カテゴリー情報）を結合したデータ
struct ExploreItemJoinedData: Equatable, Hashable {
    var categoryIDs: [String]
    var categoryNames: [String]
    var createdTime: Timestamp?
    var description: String
    var iconImageURL: String
    var id: String?
    var name: String
    var serviceID: String
    var serviceURL: String?

    static func makeEmptyData() -> ExploreItemJoinedData {
        return ExploreItemJoinedData(
            categoryIDs: ["", ""],
            categoryNames: ["", ""],
            description: "",
            iconImageURL: "",
            id: nil,
            name: "",
            serviceID: "",
            serviceURL: ""
        )
    }
}

#if DEBUG
let demoExploreItemJoinedDatas = [
    ExploreItemJoinedData(
        categoryIDs: ["demo-id"],
        categoryNames: ["demo-name"],
        createdTime: nil,
        description: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        iconImageURL: "https://via.placeholder.com/150",
        id: "demo-01",
        name: "demo-name",
        serviceID: "demo-service-id",
        serviceURL: ""
    ),
    ExploreItemJoinedData(
        categoryIDs: ["demo-id"],
        categoryNames: ["demo-name"],
        createdTime: nil,
        description: "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
        iconImageURL: "https://via.placeholder.com/150",
        id: "demo-01",
        name: "demo-name",
        serviceID: "demo-service-id",
        serviceURL: ""
    )
]
#endif
