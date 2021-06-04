//
//  Date+ToString.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/23.
//

import Foundation

extension Date {

    /// DateからStringを生成
    func toString(format: DateFormatter.Template, timeZone: TimeZone = TimeZone.init(identifier: "GMT")!) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = timeZone
        return formatter.string(from: self)
    }
}
