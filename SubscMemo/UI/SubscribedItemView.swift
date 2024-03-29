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
    let iconColor: Color

    var body: some View {
        return
            ZStack {
                Rectangle()
                    .fill(Color.adaptiveWhite)
                    .cornerRadius(20)
                    .adaptiveShadow()

                HStack(alignment: .center) {
                    ServiceIconImageView(iconColor: iconColor,
                                         serviceURL: vm.item.serviceURL,
                                         serviceName: vm.item.serviceName)
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
                                        .foregroundColor(.adaptiveBlack)

                                    Text(vm.item.planName ?? "")
                                        .adaptiveFont(.matterMedium, size: 12)
                                        .foregroundColor(.adaptiveBlack)
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
                                        .foregroundColor(.adaptiveBlack)
                                        .lineLimit(2)
                                }
                            }
                        }
                    }
                    .padding(.trailing)
                }
            }
            .frame(height: 120)
    }
}

#if DEBUG

struct SubscribedItemView_Previews: PreviewProvider {

    static var content: some View {
        NavigationView {
            SubscribedItemView(vm: demoSubscribedItemVMs[0],
                               iconColor: Color.orange)
        }
    }

    static var previews: some View {
        return
            Group {
                content
                    .environment(\.colorScheme, .light)

                content
                    .environment(\.colorScheme, .dark)
            }
    }
}

#endif
