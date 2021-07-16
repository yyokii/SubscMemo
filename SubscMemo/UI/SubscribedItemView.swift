//
//  SubscribedItemView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/10.
//

import SwiftUI

/// 加入済みサービスの情報を表示するView
struct SubscribedItemView: View {
    @StateObject var vm: SubscribedItemViewModel

    var body: some View {
        return
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(20)

                HStack(alignment: .center) {
                    ServiceIconImageView(iconImageURL: vm.item.iconImageURL, serviceName: vm.item.serviceName)
                        .frame(width: 50, height: 50)
                        .cornerRadius(25)
                        .padding()

                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(vm.item.serviceName)
                                        .adaptiveFont(.matterSemiBold, size: 12)
                                        .padding(.bottom, 5)
                                        .foregroundColor(.appBlack)

                                    Text(vm.item.planName ?? "")
                                        .adaptiveFont(.matterMedium, size: 12)
                                        .foregroundColor(.appBlack)
                                }
                            }
                        }

                        Spacer()

                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(vm.item.price)
                                        .padding(.bottom, 5)
                                        .adaptiveFont(.matterSemiBold, size: 12
                                        )
                                        .foregroundColor(.green)
                                        .padding([.bottom])

                                    Text(vm.item.cycle)
                                        .adaptiveFont(.matter, size: 12)
                                        .foregroundColor(.appBlack)
                                        .lineLimit(2)
                                }
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
                SubscribedItemView(vm: demoSubscribedItemVMs[0])
                    .environment(\.colorScheme, .light)

                SubscribedItemView(vm: demoSubscribedItemVMs[0])
                    .environment(\.colorScheme, .dark)
            }
    }
}

#endif
