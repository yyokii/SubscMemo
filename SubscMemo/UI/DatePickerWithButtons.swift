//
//  DatePickerWithButtons.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/22.
//

import SwiftUI

struct DatePickerWithButtons: View {

    let dateRange: ClosedRange<Date>

    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date?
    @State var selectingDate: Date = Date()

    var body: some View {
        VStack {
            DatePicker(
                "",
                selection: $selectingDate,
                in: dateRange,
                displayedComponents: [.date]
            )
            .datePickerStyle(GraphicalDatePickerStyle())

            Divider()

            HStack {
                Button(action: {
                    savedDate = nil
                    showDatePicker = false
                }, label: {
                    Text("リセット")
                        .adaptiveFont(.matterMedium, size: 16)
                        .foregroundColor(.red)
                })

                Spacer()

                Button(action: {
                    savedDate = selectingDate
                    showDatePicker = false
                }, label: {
                    Text("設定".uppercased())
                        .adaptiveFont(.matterMedium, size: 16)
                })

            }
            .padding(.horizontal)

        }
        .padding()
        .background(
            Color.adaptiveWhite
                .cornerRadius(30)
        )
    }
}

#if DEBUG

struct PaymentDatePickerView: View {

    @State var showDatePicker: Bool = false
    @State var savedDate: Date?

    let dateRange: ClosedRange<Date>

    var body: some View {
        ZStack {
            HStack {
                Text("次回支払い日")
                    .adaptiveFont(.matterSemiBold, size: 8)
                    .foregroundColor(.placeholderGray)

                Spacer()

                Button(action: {
                    showDatePicker.toggle()
                }, label: {
                    Text(savedDate?.description ?? "設定されていません")
                })
            }

            if showDatePicker {
                DatePickerWithButtons(
                    dateRange: dateRange,
                    showDatePicker: $showDatePicker,
                    savedDate: $savedDate,
                    selectingDate: savedDate ?? Date()
                )
                .animation(.linear)
                .transition(.opacity)

            }
        }

    }
}

struct DatePickerWithButtons_Previews: PreviewProvider {

    struct ContentView: View {
        let dateRange: ClosedRange<Date> = {
            let now = Date()

            let calendar = Calendar.japanCalendar
            let oneYearAgoDate = calendar.date(
                byAdding: .year,
                value: 3,
                to: now)

            return now ... oneYearAgoDate!
        }()

        var body: some View {
            NavigationView {
                PaymentDatePickerView(dateRange: dateRange)
            }
        }
    }

    static var previews: some View {

        Group {
            ContentView()
                .environment(\.colorScheme, .light)

            ContentView()
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
