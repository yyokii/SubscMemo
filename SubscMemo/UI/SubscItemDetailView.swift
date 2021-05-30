//
//  SubscItemDetailView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/12.
//

import SwiftUI

struct SubscItemDetailView: View {

    @Binding var subscItem: SubscribedItem

    var body: some View {
        ZStack {

            // ベースカラー
            Color.adaptiveWhite
                .ignoresSafeArea()

            VStack {
                ScrollView {
                    VStack {
                        Image(systemName: "scribble.variable")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .padding(.top, 30)

                        VStack(alignment: .leading) {
                            Text(subscItem.name)
                                .adaptiveFont(.matterSemiBold, size: 24)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(2)
                                .foregroundColor(.adaptiveBlack)

                            #warning("viewDataいるやん")
                            Text(subscItem.mainCategoryID)
                                .adaptiveFont(.matterSemiBold, size: 16)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(2)
                                .padding(.top)
                                .foregroundColor(.gray)

                            HStack {
                                Text("プラン名プラン名プラン名プラン名プラン名")
                                    .adaptiveFont(.matterSemiBold, size: 16)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(3)
                                    .foregroundColor(.adaptiveBlack)

                                Spacer()

                                Text("1,200/月")
                                    .adaptiveFont(.matterSemiBold, size: 22)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(2)
                                    .foregroundColor(.adaptiveBlack)
                            }
                            .padding(.top, 20)

                            Text(subscItem.description)
                                .adaptiveFont(.matterSemiBold, size: 16)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.top, 40)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .padding(.top, 40)
                    }

                }

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
        }
    }
}

#if DEBUG

struct SubscItemDetailView_Previews: PreviewProvider {
    static var previews: some View {

        Group {

            let item = Binding<SubscribedItem>(
                get: { demoSubscItems[0] },
                set: { _ in () }
            )

            SubscItemDetailView(subscItem: item)
                .environment(\.colorScheme, .light)

            SubscItemDetailView(subscItem: item)
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
