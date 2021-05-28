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
    @Binding var isPresented: Bool
    @Binding var selectedData: String

    var body: some View {

        VStack {
            Text(selectedData)
                .adaptiveFont(.matterSemiBold, size: 16)
                .foregroundColor(.adaptiveBlack)
                .padding(.top, 20)

            Picker("", selection: $selectedData) {
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

    struct ContentView: View {
        var datas = demoSubscCategories.map { $0.name }
        @State var data = ""

        var body: some View {
            NavigationView {
                VStack {
                    OptionalablePickerView(
                        datas: datas,
                        isOptionalPick: false,
                        isPresented: .constant(false),
                        selectedData: $data
                    )

                    Divider()

                    OptionalablePickerView(
                        datas: datas,
                        isOptionalPick: true,
                        isPresented: .constant(false),
                        selectedData: $data
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
