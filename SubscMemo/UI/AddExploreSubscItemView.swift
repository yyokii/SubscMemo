//
//  AddExploreSubscItemView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/08.
//

import SwiftUI

struct AddExploreSubscItemView: View {
    @ObservedObject var addExploreSubscItemVM: AddExploreSubscItemViewModel
    @State private var dialogPresentation = DialogPresentation()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "scribble.variable")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding([.trailing], 8)

                    TextField("サービス名", text: $addExploreSubscItemVM.subscItem.name)
                        .adaptiveFont(.matterSemiBold, size: 16)
                        .disabled(true)
                        .foregroundColor(.adaptiveBlack)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)

                Form {
                    Section(header: Text("🗒 サービス概要")) {

                        SubscItemTextField(isDisabled: true, placeholder: "サービスのURL", text: $addExploreSubscItemVM.subscItem.serviceURL ?? "")

                        SubscItemTextField(isDisabled: true, placeholder: "サービス情報", text: $addExploreSubscItemVM.subscItem.description)
                            .disabled(true)
                    }

                    Section(header: Text("💎 プラン")) {
                        SelectSubscPlanView(plans: addExploreSubscItemVM.planDatas, selectSubscPlanVM: addExploreSubscItemVM.selectSubscPlanViewModel)
                    }

                    Section(header: Text("💰 支払い")) {

                        SubscItemTextField(isDisabled: false, placeholder: "料金", text: $addExploreSubscItemVM.subscItem.price.intToString(0))

                        // 支払いサイクル選択
                        HStack {
                            PaymentCyclePickerView(
                                selectedCycle: $addExploreSubscItemVM.subscItem.cycle)
                        }

                        SubscItemTextField(isDisabled: true, placeholder: "プラン名", text: $addExploreSubscItemVM.subscItem.planName ?? "")
                    }
                }
                .padding(.top, 10)

                Button(action: {

                }) {
                    Text("追加する")
                        .adaptiveFont(.matterMedium, size: 16)
                        .foregroundColor(.adaptiveBlack)
                        .frame(minWidth: 0, maxWidth: 300)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.adaptiveWhite)
                                .adaptiveShadow()
                        )
                        .padding()
                }
                .padding(8)
            }
            .navigationBarHidden(true) // バックグラウンドから戻ってきたら表示されてるかも？  https://filipmolcik.com/how-to-hide-swiftui-navigationbar/
        }
        .customDialog(presentationManager: dialogPresentation)
    }
}

#if DEBUG

struct AddExploreSubscItemView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            AddExploreSubscItemView(addExploreSubscItemVM: demoAddExploreSubscItemVM)
                .environment(\.colorScheme, .light)
            AddExploreSubscItemView(addExploreSubscItemVM: demoAddExploreSubscItemVM)
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
