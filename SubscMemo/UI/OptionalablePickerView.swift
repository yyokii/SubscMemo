//
//  OptionalablePickerView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/23.
//

import SwiftUI

struct OptionalablePickerView: View {

    let datas: [String]
    var isOptionalPick: Bool = false
    @Binding var selectedData: String
    let title: String

    var body: some View {

        Picker(title, selection: $selectedData) {

            if isOptionalPick {
                Text("選択しない")
                    .tag("")
                    .foregroundColor(.adaptiveBlack)
            }

            ForEach(datas, id: \.self) { data in
                Text(data)
                    .foregroundColor(.adaptiveBlack)
            }
        }
        .adaptiveFont(.matterSemiBold, size: 8)
        .foregroundColor(.placeholderGray)
        .buttonStyle(PlainButtonStyle())
    }
}

#if DEBUG

struct OptionalablePickerView_Previews: PreviewProvider {

    struct ContentView: View {
        var datas = demoSubscCategories.map { $0.name }
        @State var data = ""

        var body: some View {
            NavigationView {
                VStack {
                    OptionalablePickerView(
                        datas: datas,
                        isOptionalPick: false,
                        selectedData: $data,
                        title: "demo"
                    )

                    Divider()

                    OptionalablePickerView(
                        datas: datas,
                        isOptionalPick: true,
                        selectedData: $data,
                        title: "demo"
                    )
                }
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
