//
//  AddExploreSubscItemView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/08.
//

import SwiftUI

struct AddExploreSubscItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm: AddExploreSubscItemViewModel

    var body: some View {
        NavigationView {
            VStack {
                Text(vm.subscItem.name)
                    .adaptiveFont(.matterSemiBold, size: 16)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                    .foregroundColor(.adaptiveBlack)
                    .padding(.top, 16)

                ValidationStateView(vm: vm.validationVM)
                    .padding(.top)

                Form {
                    Section(header: Text("💎 プラン")) {
                        SelectSubscPlanView(
                            plans: vm.planDatas,
                            selectSubscPlanVM: vm.selectSubscPlanViewModel
                        )
                        .padding(.vertical, 8)
                    }

                    Section(header: Text("💰 支払い")) {

                        PriceTextField(
                            placeholder: "料金",
                            text: $vm.subscItem.price.intToString(0)
                        )

                        // 支払いサイクル選択
                        PaymentCyclePickerView(
                            selectedCycle: $vm.subscItem.cycle
                        )

                        SubscItemTextField(
                            isDisabled: true,
                            placeholder: "プラン名",
                            text: $vm.subscItem.planName ?? ""
                        )
                    }
                }
                .padding(.top, 10)

                Button("追加する") {
                    vm.addItem()
                }
                .buttonStyle(ActionButtonStyle())
                .padding(10)
            }
            .navigationBarHidden(true) // バックグラウンドから戻ってきたら表示されてるかも？  https://filipmolcik.com/how-to-hide-swiftui-navigationbar/
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

struct AddExploreSubscItemView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            AddExploreSubscItemView(vm: demoAddExploreSubscItemVM)
                .environment(\.colorScheme, .light)
            AddExploreSubscItemView(vm: demoAddExploreSubscItemVM)
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
