//
//  CreateCustomSubscItemView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/20.
//

import SwiftUI

struct CreateCustomSubscItemView: View {
    @ObservedObject var createCustomSubscItemVM = CreateCustomSubscItemViewModel()
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
            ZStack {
                VStack {
                    Image(systemName: "scribble.variable")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .padding(.top, 10)

                    TextField("サービス名", text: $createCustomSubscItemVM.subscItem.name)
                        .adaptiveFont(.matterSemiBold, size: 16)
                        .foregroundColor(.adaptiveBlack)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 20)
                        .padding(.horizontal, 30)

                    Form {
                        Section(header: Text("🗒 サービス概要")) {
                            SubscItemTextField(placeholder: "サービスのURL", text: $createCustomSubscItemVM.subscItem.serviceURL ?? "")
                            SubscItemTextField(placeholder: "サービス情報", text: $createCustomSubscItemVM.subscItem.description)
                        }

                        Section(header: Text("💰 支払い")) {
                            SubscItemTextField(placeholder: "料金", text: $createCustomSubscItemVM.subscItem.price.intToString(0))

                            // 支払いサイクル選択
                            HStack {
                                Text("支払いサイクル")
                                    .adaptiveFont(.matterSemiBold, size: 8)
                                    .foregroundColor(.placeholderGray)

                                Spacer()

                                Button(action: {
                                    dialogPresentation.show(
                                        content: .selectPaymentCycle(isPresented: $dialogPresentation.isPresented, text: $createCustomSubscItemVM.subscItem.cycle))
                                }) {
                                    Text(createCustomSubscItemVM.subscItem.cycle)
                                }
                            }

                            SubscItemTextField(placeholder: "プラン名", text: $createCustomSubscItemVM.subscItem.planName ?? "")

                            // 日付選択
                            HStack {
                                Text("次回支払い日")
                                    .adaptiveFont(.matterSemiBold, size: 8)
                                    .foregroundColor(.placeholderGray)

                                Spacer()

                                Button(action: {
                                    dialogPresentation.show(
                                        content: .selectDate(
                                            isPresented: $dialogPresentation.isPresented,
                                            dateRange: nextPaymentDateRange,
                                            savedDate: $createCustomSubscItemVM.payAtDate,
                                            selectingDate: createCustomSubscItemVM.payAtDate ?? Date())
                                    )
                                }, label: {
                                    let date = createCustomSubscItemVM.payAtDate?.toString(format: .yMd, timeZone: .japan) ?? "設定されていません"
                                    Text(date)
                                })
                            }
                        }

                        Section(header: Text("🧹 カテゴリー")) {
                            // カテゴリー選択
                            HStack {
                                Text("メインカテゴリー")
                                    .adaptiveFont(.matterSemiBold, size: 8)
                                    .foregroundColor(.placeholderGray)

                                Spacer()

                                Button(action: {
                                    dialogPresentation.show(
                                        content: .selectMainCategory(
                                            isPresented: $dialogPresentation.isPresented,
                                            datas: createCustomSubscItemVM.categories,
                                            selectedData: $createCustomSubscItemVM.mainCategory
                                        )
                                    )
                                }) {
                                    Text(createCustomSubscItemVM.mainCategory.name)
                                }
                            }

                            HStack {
                                Text("サブカテゴリー")
                                    .adaptiveFont(.matterSemiBold, size: 8)
                                    .foregroundColor(.placeholderGray)

                                Spacer()

                                Button(action: {
                                    dialogPresentation.show(
                                        content: .selectMainCategory(
                                            isPresented: $dialogPresentation.isPresented,
                                            datas: createCustomSubscItemVM.categories,
                                            selectedData: $createCustomSubscItemVM.subCategory
                                        )
                                    )
                                }) {
                                    Text(createCustomSubscItemVM.subCategory.name)
                                }
                            }
                        }
                    }
                    .padding(.top, 30)

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
                                    .shadow(color: .gray, radius: 5, x: 0, y: 5)
                            )
                            .padding()
                    }
                    .padding(8)
                }
                #warning("非表示にする件未検証")
            }
            .navigationBarHidden(true) // バックグラウンドから戻ってきたら表示されてるかも？  https://filipmolcik.com/how-to-hide-swiftui-navigationbar/
        }
        .customDialog(presentationManager: dialogPresentation)
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
