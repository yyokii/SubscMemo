//
//  SubscItem.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/10.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct SubscItem: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
}

#if DEBUG
let testDataTasks = [
    SubscItem(title: "Implement UI", completed: true),
    SubscItem(title: "Connect to Firebase", completed: false)
]
#endif

//final class SubscItem: Object, DataRepresentable, DataListenable, ObservableObject, Identifiable {
//
//    typealias ID = String
//
//    override class var name: String { "subscItems" }
//
//    struct Model: Codable, Modelable {
//
//        var title: String = ""
//        var price: Int = 0
//        var cycle: String = ""
//        var payAt: Timestamp!
//        var plan: String?
//        var category: String?
//        var url: String?
//        var description: String?
//        var createdAt: ServerTimestamp?
//    }
//
//    @Published var data: SubscItem.Model?
//
//    var listener: ListenerRegistration?
//}
