//
//  CreateCustomSubscItemView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/20.
//

import SwiftUI

struct CreateCustomSubscItemView: View {
    @StateObject var createCustomSubscItemVM = CreateCustomSubscItemViewModel()
    @State private var dialogPresentation = DialogPresentation()

    let nextPaymentDateRange: ClosedRange<Date> = {
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
            VStack {
                ValidationStateView(vm: createCustomSubscItemVM.validationVM)
                    .padding(.top)

                Form {
                    Section(header: Text("🗒 サービス概要")) {
                        SubscItemTextField(placeholder: "サービス名", text: $createCustomSubscItemVM.subscItem.name)

                        SubscItemTextField(placeholder: "サービスのURL", text: $createCustomSubscItemVM.subscItem.serviceURL ?? "")
                        SubscItemTextField(placeholder: "サービス情報", text: $createCustomSubscItemVM.subscItem.description)
                    }

                    Section(header: Text("🎨 カテゴリー")) {
                        // カテゴリー選択
                        SubscCategoryPickerView(
                            datas: createCustomSubscItemVM.categories,
                            selectedData: $createCustomSubscItemVM.mainCategory,
                            title: "メインカテゴリー"
                        )

                        SubscCategoryPickerView(
                            datas: createCustomSubscItemVM.categories,
                            selectedData: $createCustomSubscItemVM.subCategory,
                            title: "サブカテゴリー"
                        )
                    }

                    Section(header: Text("💰 支払い")) {
                        SubscItemTextField(placeholder: "料金", text: $createCustomSubscItemVM.subscItem.price.intToString(0))

                        // 支払いサイクル選択
                        HStack {
                            PaymentCyclePickerView(
                                selectedCycle: $createCustomSubscItemVM.subscItem.cycle)
                        }

                        SubscItemTextField(placeholder: "プラン名", text: $createCustomSubscItemVM.subscItem.planName ?? "")

                        //                        // 日付選択
                        //                        HStack {
                        //                            Text("次回支払い日")
                        //                                .adaptiveFont(.matterSemiBold, size: 8)
                        //                                .foregroundColor(.placeholderGray)
                        //
                        //                            Spacer()
                        //
                        //                            Button(action: {
                        //                                dialogPresentation.show(
                        //                                    content: .selectDate(
                        //                                        isPresented: $dialogPresentation.isPresented,
                        //                                        dateRange: nextPaymentDateRange,
                        //                                        savedDate: $createCustomSubscItemVM.payAtDate,
                        //                                        selectingDate: createCustomSubscItemVM.payAtDate ?? Date())
                        //                                )
                        //                            }, label: {
                        //                                let date = createCustomSubscItemVM.payAtDate?.toString(format: .yMd, timeZone: .japan) ?? "設定されていません"
                        //                                Text(date)
                        //                            })
                        //                        }
                    }
                }

                Button(action: {
                    createCustomSubscItemVM.addItem()
                }) {
                    Text("追加する")
                        .adaptiveFont(.matterMedium, size: 16)
                        .foregroundColor(.appBlack)
                        .frame(minWidth: 0, maxWidth: 300)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.white)
                                .adaptiveShadow()
                        )
                        .padding()
                }
                .padding(8)
            }
            .navigationTitle("追加する")
        }
    }
}

#if DEBUG

struct CreateCustomSubscItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreateCustomSubscItemView(createCustomSubscItemVM: demoCreateCustomSubscItemVM)
                .environment(\.colorScheme, .light)

            CreateCustomSubscItemView(createCustomSubscItemVM: demoCreateCustomSubscItemVM)
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
