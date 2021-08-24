//
//  Banner.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Banner: Codable {
    @DocumentID var id: String?
    var endDate: Timestamp
    var imageURL: String
    var startDate: Timestamp

    func isActive() -> Bool {
        let now = Date()
        return (now >= startDate.dateValue()) && (now <= endDate.dateValue())
    }
}
