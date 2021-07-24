//
//  SubscMemoWidget.swift
//  SubscMemoWidget
//
//  Created by Higashihara Yoki on 2021/07/23.
//

import WidgetKit
import SwiftUI

/*
 Debug Reference
 https://developer.apple.com/documentation/widgetkit/debugging-widgets
 */

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> UserDataEntry {
        UserDataEntry(
            date: Date(),
            subscribedSurviceCount: 0,
            monthlyPayment: 0,
            yearlyPayment: 0
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (UserDataEntry) -> Void) {
        let entry = UserDataEntry(
            date: Date(),
            subscribedSurviceCount: 3,
            monthlyPayment: 1000,
            yearlyPayment: 12000
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var entries: [UserDataEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = UserDataEntry(
                date: entryDate,
                subscribedSurviceCount: 5,
                monthlyPayment: 10000,
                yearlyPayment: 200000
            )
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct UserDataEntry: TimelineEntry {
    var date: Date

    let subscribedSurviceCount: Int
    let monthlyPayment: Int
    let yearlyPayment: Int
}

struct SubscMemoWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct SubscMemoWidget: Widget {
    let kind: String = "SubscMemoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SubscMemoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

#if DEBUG

struct SubscMemoWidget_Previews: PreviewProvider {
    static var previews: some View {
        SubscMemoWidgetEntryView(entry: UserDataEntry(
            date: Date(),
            subscribedSurviceCount: 5,
            monthlyPayment: 10000,
            yearlyPayment: 200000
        ))
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

#endif
