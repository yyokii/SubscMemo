//
//  PaymentCycle.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/07/03.
//

enum PaymentCycle: String, CaseIterable, Identifiable {
    case daily
    case weekly
    case monthly
    case every3months = "every_3_months"
    case every6months = "every_6_months"
    case yearly

    var id: String { self.rawValue }

    var title: String {
        switch self {
        case .daily:
            return "毎日"
        case .weekly:
            return "毎週"
        case .monthly:
            return "毎月"
        case .every3months:
            return "3ヶ月毎"
        case .every6months:
            return "6ヶ月毎"
        case .yearly:
            return "1年毎"
        }
    }
}
