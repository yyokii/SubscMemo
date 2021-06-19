//
//  SubscCategoryPickerView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/23.
//

import SwiftUI

struct SubscCategoryPickerView: View {

    let datas: [SubscCategory]
    var isOptionalPick: Bool = false
    @Binding var isPresented: Bool
    @Binding var selectedData: SubscCategory

    var body: some View {
        VStack {
            Text(selectedData.name)
                .adaptiveFont(.matterSemiBold, size: 16)
                .foregroundColor(.adaptiveBlack)
                .padding(.top, 20)

            Picker("", selection: $selectedData) {
                if isOptionalPick {
                    Text("選択しない")
                        .tag(SubscCategory.makeEmptyData())
                        .foregroundColor(.adaptiveBlack)
                }

                ForEach(datas) { data in
                    Text(data.name)
                        .foregroundColor(.adaptiveBlack)
                }
            }
            .adaptiveFont(.matterSemiBold, size: 8)
            .foregroundColor(.placeholderGray)
            .buttonStyle(PlainButtonStyle())

            Button(action: {
                isPresented = false
            }) {
                Text("閉じる")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.bottom, 20)
            }

        }
        .background(Color.adaptiveWhite)
        .cornerRadius(8)
    }
}

#if DEBUG

struct OptionalablePickerView_Previews: PreviewProvider {

    struct ContentView01: View {
        var datas = demoSubscCategories
        @ObservedObject var vm = demoCreateCustomSubscItemVM
        @State private var dialogPresentation = DialogPresentation()

        var body: some View {
            NavigationView {
                VStack {
                    SubscCategoryPickerView(
                        datas: vm.categories,
                        isOptionalPick: false,
                        isPresented: .constant(false),
                        selectedData: $vm.mainCategory
                    )

                    Divider()

                    SubscCategoryPickerView(
                        datas: vm.categories,
                        isOptionalPick: true,
                        isPresented: .constant(false),
                        selectedData: $vm.mainCategory
                    )
                }
            }
        }
    }

    struct ContentView02: View {
        var datas = demoSubscCategories
        @State var data: SubscCategory = SubscCategory.makeEmptyData()
        @ObservedObject var vm = demoCreateCustomSubscItemVM
        @State private var dialogPresentation = DialogPresentation()

        var body: some View {
            NavigationView {
                Form {
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
                                        datas: vm.categories,
                                        selectedData: $vm.mainCategory
                                    )
                                )
                            }) {
                                Text(vm.mainCategory.name)
                            }
                        }
                    }
                }
            }
            .customDialog(presentationManager: dialogPresentation)
        }
    }

    static var previews: some View {

        Group {
            ContentView01()
                .environment(\.colorScheme, .light)

            ContentView01()
                .environment(\.colorScheme, .dark)
        }

        Group {
            ContentView02()
                .environment(\.colorScheme, .light)

            ContentView02()
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
