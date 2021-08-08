//
//  CreateCustomSubscItemView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/20.
//

import SwiftUI

struct CreateCustomSubscItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm = CreateCustomSubscItemViewModel()
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
                ValidationStateView(vm: vm.validationVM)
                    .padding(.top)

                Form {
                    Section(header: Text("🗒 サービス概要")) {
                        SubscItemTextField(placeholder: "サービス名", text: $vm.subscItem.name)

                        SubscItemTextField(placeholder: "サービスのURL", text: $vm.subscItem.serviceURL ?? "")
                        SubscItemTextField(placeholder: "サービス情報", text: $vm.subscItem.description)
                    }

                    Section(header: Text("🎨 カテゴリー")) {
                        // カテゴリー選択
                        SubscCategoryPickerView(
                            datas: vm.categories,
                            selectedData: $vm.mainCategory,
                            title: "メインカテゴリー"
                        )

                        SubscCategoryPickerView(
                            datas: vm.categories,
                            selectedData: $vm.subCategory,
                            title: "サブカテゴリー"
                        )
                    }

                    Section(header: Text("💰 支払い")) {
                        PriceTextField(placeholder: "料金", text: $vm.subscItem.price.intToString(0))

                        // 支払いサイクル選択
                        HStack {
                            PaymentCyclePickerView(
                                selectedCycle: $vm.subscItem.cycle)
                        }

                        SubscItemTextField(placeholder: "プラン名", text: $vm.subscItem.planName ?? "")

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
                        //                                        savedDate: $vm.payAtDate,
                        //                                        selectingDate: vm.payAtDate ?? Date())
                        //                                )
                        //                            }, label: {
                        //                                let date = vm.payAtDate?.toString(format: .yMd, timeZone: .japan) ?? "設定されていません"
                        //                                Text(date)
                        //                            })
                        //                        }
                    }
                }

                Button("追加する") {
                    vm.addItem()
                }
                .buttonStyle(ActionButtonStyle())
                .padding(10)
            }
            .navigationTitle("追加する")
        }
        .alert(isPresented: $vm.alertProvider.shouldShowAlert ) {
            guard let alert = vm.alertProvider.alert else { fatalError("💔: Alert not available")
            }
            return Alert(alert)
        }
        .onReceive(vm.dismissViewPublisher) { shouldDismiss in
            if shouldDismiss {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#if DEBUG

struct CreateCustomSubscItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreateCustomSubscItemView(vm: demoCreateCustomSubscItemVM)
                .environment(\.colorScheme, .light)

            CreateCustomSubscItemView(vm: demoCreateCustomSubscItemVM)
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
