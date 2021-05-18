//
//  SubscCategory.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/04/07.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct SubscCategory: Codable, Identifiable {
    @DocumentID var id: String?
    var categoryID: String
    var iconImageURL: String
    var name: String
}

#if DEBUG

let demoSubscCategories = [
    SubscCategory(id: "id-01", categoryID: "categoryID-01", iconImageURL: "https://via.placeholder.com/50", name: "ソーシャルネットワーキング"),
    SubscCategory(id: "id-02", categoryID: "categoryID-02", iconImageURL: "https://via.placeholder.com/50", name: "写真/動画"),
    SubscCategory(id: "id-03", categoryID: "categoryID-03", iconImageURL: "https://via.placeholder.com/50", name: "教育")
]

#endif