//
//  SubscItem.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/10.
//

import Ballcap
import FirebaseFirestore

final class SubscItem: Object, DataRepresentable, DataListenable, ObservableObject, Identifiable {

    typealias ID = String

    override class var name: String { "subscItems" }

    struct Model: Codable, Modelable {

        var title: String = ""
        var price: Int = 0
        var cycle: String = ""
        var payAt: Timestamp!
        var plan: String?
        var category: String?
        var url: String?
        var description: String?
        var createdAt: ServerTimestamp?
    }

    @Published var data: SubscItem.Model?

    var listener: ListenerRegistration?
}
