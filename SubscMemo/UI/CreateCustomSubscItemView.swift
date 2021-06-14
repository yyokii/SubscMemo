//
//  CreateCustomSubscItemView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/20.
//

import SwiftUI

struct CreateCustomSubscItemView: View {

    @State private var dialogPresentataion = DialogPresentation()

    // デモ用
    @State var hoge: String = ""
    @Binding var subscItem: SubscribedItem

    // 支払いサイクル設定
    @State var cycle: String?

    // カテゴリ選択関連
    let categories = ["a", "b", "c"]
    @State var mainCategory = ""
    @State var subCategory = ""

    // 支払い日選択View関連
    @State var showDatePicker: Bool = false
    @State var savedDate: Date?
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

                    TextField("サービス名", text: $hoge)
                        .adaptiveFont(.matterSemiBold, size: 16)
                        .foregroundColor(.adaptiveBlack)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 20)
                        .padding(.horizontal, 30)

                    Form {
                        Section(header: Text("🗒 サービス概要")) {

                            SubscItemTextField(placeholder: "サービスのURL", text: $hoge)

                            SubscItemTextField(placeholder: "サービス情報", text: $hoge)
                        }

                        Section(header: Text("💰 支払い")) {

                            SubscItemTextField(placeholder: "料金", text: $hoge)

                            // 支払いサイクル選択
                            HStack {
                                Text("支払いサイクル")
                                    .adaptiveFont(.matterSemiBold, size: 8)
                                    .foregroundColor(.placeholderGray)

                                Spacer()

                                Button(action: {
                                    dialogPresentataion.show(
                                        content: .selectPaymentCycle(isPresented: $dialogPresentataion.isPresented, text: $subscItem.cycle))
                                }) {
                                    Text(subscItem.cycle)
                                }
                            }

                            SubscItemTextField(placeholder: "プラン名", text: $hoge)

                            // 日付選択
                            HStack {
                                Text("次回支払い日")
                                    .adaptiveFont(.matterSemiBold, size: 8)
                                    .foregroundColor(.placeholderGray)

                                Spacer()

                                Button(action: {
                                    dialogPresentataion.show(
                                        content: .selectDate(
                                            isPresented: $dialogPresentataion.isPresented,
                                            dateRange: nextPaymentDateRange,
                                            savedDate: $savedDate,
                                            selectingDate: savedDate ?? Date())
                                    )
                                    //                                    showDatePicker.toggle()
                                }, label: {
                                    let date = savedDate?.toString(format: .yMd, timeZone: .japan) ?? "設定されていません"
                                    Text(date)
                                })
                            }

                            SubscItemTextField(placeholder: "次回支払い日", text: $hoge)
                        }

                        Section(header: Text("🧹 カテゴリー")) {

                            // カテゴリー選択
                            HStack {
                                Text("メインカテゴリー")
                                    .adaptiveFont(.matterSemiBold, size: 8)
                                    .foregroundColor(.placeholderGray)

                                Spacer()

                                Button(action: {
                                    dialogPresentataion.show(
                                        content: .selectMainCategory(isPresented: $dialogPresentataion.isPresented, datas: ["ソーシャルネットワーク", "音楽"], selectedData: $mainCategory))
                                }) {
                                    Text(mainCategory)
                                }
                            }

                            HStack {
                                Text("サブカテゴリー")
                                    .adaptiveFont(.matterSemiBold, size: 8)
                                    .foregroundColor(.placeholderGray)

                                Spacer()

                                Button(action: {
                                    dialogPresentataion.show(
                                        content: .selectMainCategory(isPresented: $dialogPresentataion.isPresented, datas: ["ソーシャルネットワーク", "音楽"], selectedData: $subCategory))
                                }) {
                                    Text(subCategory)
                                }
                            }
                        }
                    }
                    .padding(.top, 30)

                    Button(action: {

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
        .customDialog(presentationManager: dialogPresentataion)
    }
}

#if DEBUG

struct CreateCustomSubscItemView_Previews: PreviewProvider {

    static let item = Binding<SubscribedItem>(
        get: { demoSubscItems[0] },
        set: { _ in () }
    )

    static var previews: some View {

        Group {

            CreateCustomSubscItemView(subscItem: item)
                .environment(\.colorScheme, .light)

            CreateCustomSubscItemView(subscItem: item)
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
