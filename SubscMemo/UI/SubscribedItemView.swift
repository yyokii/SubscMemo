//
//  SubscribedItemView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/10.
//

import SwiftUI

/// 加入済みサービスの情報を表示するView
struct SubscribedItemView: View {
    @ObservedObject var subscribedItemVM: SubscribedItemViewModel

    var body: some View {
        return
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(20)

                HStack(alignment: .center) {
                    Image(systemName: "scribble")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding()

                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(subscribedItemVM.item.serviceName)
                                    .adaptiveFont(.matterSemiBold, size: 12)
                                    .padding(.bottom, 10)
                                    .foregroundColor(.appBlack)

                                Text(subscribedItemVM.item.planName ?? "")
                                    .adaptiveFont(.matterMedium, size: 12)
                                    .foregroundColor(.appBlack)
                            }
                        }
                    }

                    Spacer()

                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(subscribedItemVM.item.price)
                                    .adaptiveFont(.matterSemiBold, size: 12)
                                    .padding(.bottom, 10)
                                    .foregroundColor(.green)

                                Text("monthly")
                                    .adaptiveFont(.matter, size: 12)
                                    .lineLimit(2)
                                    .foregroundColor(.appBlack)

                            }
                        }
                    }
                    .padding(.trailing)
                }
            }
            .frame(height: 120)
            .shadow(color: .gray, radius: 20, x: 0, y: 20)

    }
}

#if DEBUG

struct SubscribedItemView_Previews: PreviewProvider {

    static var previews: some View {
        return
            Group {
                SubscribedItemView(subscribedItemVM: demoSubscribedItemVMs[0])
                    .environment(\.colorScheme, .light)

                SubscribedItemView(subscribedItemVM: demoSubscribedItemVMs[0])
                    .environment(\.colorScheme, .dark)
            }
    }
}

#endif
