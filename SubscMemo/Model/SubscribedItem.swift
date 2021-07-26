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
    var categoryIDs: [String]
    var cycle: String
    var description: String
    var iconImageURL: String
    @DocumentID var id: String?
    var isUserOriginal: Bool // true: ユーザーが独自に追加したもの, false: アプリが提供しているサービス群から追加したもの
    var memo: String
    var name: String
    var planID: String?
    var planName: String? // アプリが提供しているサービス群から選択している場合で且つプランを選択しているとその名称が入る
    var price: Int
    var payAt: Timestamp?
    var serviceID: String
    var serviceURL: String?
    @ServerTimestamp var createdTime: Timestamp?

    static func makeEmptyData(isUserOriginal: Bool) -> SubscribedItem {
        return SubscribedItem(
            categoryIDs: ["", ""],
            cycle: "",
            description: "",
            iconImageURL: "",
            id: nil,
            isUserOriginal: isUserOriginal,
            memo: "",
            name: "",
            planID: nil,
            planName: "",
            price: 0,
            payAt: nil,
            serviceID: "",
            serviceURL: nil
        )
    }

    static func translate(from input: ExploreItemJoinedData) -> Self {
        SubscribedItem(
            categoryIDs: input.categoryIDs,
            cycle: "",
            description: input.description,
            iconImageURL: input.iconImageURL,
            id: nil,
            isUserOriginal: false,
            memo: "",
            name: input.name,
            planID: nil,
            planName: nil,
            price: 0,
            payAt: nil,
            serviceID: input.serviceID,
            serviceURL: input.serviceURL,
            createdTime: nil
        )
    }

    mutating func setMainCategoryID(categoryID: String) {
        categoryIDs[0] = categoryID
    }

    mutating func setSubCategoryID(categoryID: String) {
        categoryIDs[1] = categoryID
    }
}

#if DEBUG
let demoSubscItems = [
    SubscribedItem(
        categoryIDs: ["demo-id"],
        cycle: "monthly",
        description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription",
        iconImageURL: "https://via.placeholder.com/50",
        id: "demo-01",

        isUserOriginal: false,
        memo: "demo-memo",
        name: "demo-01",
        planID: nil,
        planName: "",
        price: 100,
        payAt: nil,
        serviceID: "",
        serviceURL: ""
    ),
    SubscribedItem(
        categoryIDs: ["demo-id"],
        cycle: "monthly",
        description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription",
        iconImageURL: "https://via.placeholder.com/50",
        id: "demo-02",
        isUserOriginal: false,
        memo: "demo-memo",
        name: "demo-01",
        planID: nil,
        planName: "",
        price: 100,
        payAt: nil,
        serviceID: "",
        serviceURL: ""
    )
]
#endif
