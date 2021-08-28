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

    let subscribedServiceDataStore = SubscribedServiceDataStoreImpl()

    func placeholder(in context: Context) -> UserDataEntry {
        UserDataEntry(
            date: Date(),
            subscribedSurviceCount: 0,
            monthlyPayment: 0,
            yearlyPayment: 0
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (UserDataEntry) -> Void) {
        // Default  Content
        let entry = UserDataEntry(
            date: Date(),
            subscribedSurviceCount: 0,
            monthlyPayment: 0,
            yearlyPayment: 0
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var entries: [UserDataEntry] = []

        let currentDate = Date()
        let entry = UserDataEntry(
            date: currentDate,
            subscribedSurviceCount: subscribedServiceDataStore.serviceCount,
            monthlyPayment: subscribedServiceDataStore.monthlyPayment,
            yearlyPayment: subscribedServiceDataStore.yearlyPayment)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct SubscMemoWidgetEntryView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily

    var entry: Provider.Entry

    var body: some View {
        switch family {
        case .systemSmall: WidgetSmall(serviceCount: entry.subscribedSurviceCount,
                                       monthlyPayment: entry.monthlyPayment,
                                       yearlyPayment: entry.yearlyPayment)
        default:
            fatalError()
        }
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
