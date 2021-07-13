//
//  SubscCategoryPickerView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/23.
//

import SwiftUI

struct SubscCategoryPickerView: View {
    let datas: [SubscCategory]
    @Binding var selectedData: SubscCategory
    let title: String

    var body: some View {
        VStack {
            Picker(title, selection: $selectedData) {
                ForEach(datas) { data in
                    Text(data.name)
                        .foregroundColor(.adaptiveBlack)
                }
            }
            .adaptiveFont(.matterSemiBold, size: 8)
            .foregroundColor(.placeholderGray)
        }
    }
}

#if DEBUG

struct OptionalablePickerView_Previews: PreviewProvider {

    struct ContentView01: View {
        var datas = demoSubscCategories
        @ObservedObject var vm = demoCreateCustomSubscItemVM

        var body: some View {
            NavigationView {
                VStack {
                    SubscCategoryPickerView(
                        datas: vm.categories,
                        selectedData: $vm.mainCategory,
                        title: "プレビュー"
                    )
                }
            }
        }
    }

    static var previews: some View {

        Group {
            ContentView01()
                .environment(\.colorScheme, .light)

            ContentView01()
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
