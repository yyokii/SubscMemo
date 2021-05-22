//
//  Calendar+Base.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/22.
//

import Foundation

extension TimeZone {

    static let japan = TimeZone(identifier: "Asia/Tokyo")!
}

extension Locale {

    static let japan = Locale(identifier: "ja_JP")
}

extension Calendar {

    static var japanCalendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .japan
        calendar.locale   = .japan
        return calendar
    }
}
