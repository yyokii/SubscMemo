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
    var name: String
}

#if DEBUG

let demoSubscCategories = [
    SubscCategory(id: "", name: "demo_category_01"),
    SubscCategory(id: "", name: "demo_category_02")
]

#endif
