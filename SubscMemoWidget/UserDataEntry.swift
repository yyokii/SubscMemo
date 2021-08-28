//
//  UserDataEntry.swift
//  SubscMemoWidget
//
//  Created by Higashihara Yoki on 2021/08/28.
//

import WidgetKit

struct UserDataEntry: TimelineEntry {
    var date: Date

    let subscribedSurviceCount: Int
    let monthlyPayment: Int
    let yearlyPayment: Int
}
