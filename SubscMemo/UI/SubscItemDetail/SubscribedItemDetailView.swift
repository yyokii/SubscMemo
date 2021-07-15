//
//  SubscribedItemDetailView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/03.
//

import SwiftUI

struct SubscribedItemDetailView: View {
    @ObservedObject var vm: SubscribedItemDetailViewModel
    @State var presentContent: PresentContent?

    var body: some View {
        ZStack {
            // ベースカラー
            Color.adaptiveWhite
                .ignoresSafeArea()

            ScrollView {
                VStack {
                    HStack {
                        ServiceIconImageView(iconImageURL: vm.subscItem.iconImageURL, serviceName: vm.subscItem.serviceName)
                            .frame(width: 70, height: 70)
                            .cornerRadius(35)
                    }
                    .frame(maxWidth: .infinity)

                    VStack(alignment: .leading) {

                        ServiceNameView(
                            serviceName: vm.subscItem.serviceName,
                            serviceURL: vm.subscItem.serviceURL,
                            linkTapAction: { url in
                                presentContent = .safariView(url: url)
                            }
                        )

                        Text(vm.subscItem.mainCategoryName)
                            .adaptiveFont(.matterSemiBold, size: 16)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(2)
                            .padding(.top)
                            .foregroundColor(.gray)

                        SubscPlanListView(plans: [vm.plan])
                            .padding(.top, 20)

                        Text(vm.subscItem.description)
                            .adaptiveFont(.matterSemiBold, size: 16)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 40)
                            .foregroundColor(.gray)

                        Text("メモ📝")
                            .padding(.top)
                        ServiceMemoView(memo: $vm.subscItem.memo)
                    }
                    .padding()
                    .padding(.top, 40)
                }
            }
        }
        .onAppear(perform: {
            vm.loadItemData()
        })
        .sheet(item: $presentContent, content: { $0 })
    }
}

#if DEBUG

struct SubscribedItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SubscribedItemDetailView(vm: demoSubscribedItemDetailVM)
                .environment(\.colorScheme, .light)

            SubscribedItemDetailView(vm: demoSubscribedItemDetailVM)
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
