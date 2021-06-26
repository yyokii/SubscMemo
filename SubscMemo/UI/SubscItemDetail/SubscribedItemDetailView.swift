//
//  SubscribedItemDetailView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/03.
//

import SwiftUI

struct SubscribedItemDetailView: View {
    @ObservedObject var subscribedItemDetailVM: SubscribedItemDetailViewModel
    @State var presentContent: PresentContent?

    var body: some View {
        ZStack {
            // ベースカラー
            Color.adaptiveWhite
                .ignoresSafeArea()

            ScrollView {
                VStack {
                    HStack {
                        Image(systemName: "scribble.variable")
                            .resizable()
                            .frame(width: 70, height: 70)
                    }
                    .frame(maxWidth: .infinity)

                    VStack(alignment: .leading) {

                        ServiceNameView(
                            serviceName: subscribedItemDetailVM.subscItem.serviceName,
                            serviceURL: subscribedItemDetailVM.subscItem.serviceURL,
                            linkTapAction: { url in
                                presentContent = .safariView(url: url)
                            }
                        )

                        Text(subscribedItemDetailVM.subscItem.mainCategoryName)
                            .adaptiveFont(.matterSemiBold, size: 16)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(2)
                            .padding(.top)
                            .foregroundColor(.gray)

                        SubscPlanListView(plans: [subscribedItemDetailVM.plan])
                            .padding(.top, 20)

                        Text(subscribedItemDetailVM.subscItem.description)
                            .adaptiveFont(.matterSemiBold, size: 16)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 40)
                            .foregroundColor(.gray)

                        Text("メモ📝")
                            .padding(.top)
                        ServiceMemoView(memo: $subscribedItemDetailVM.subscItem.memo)
                    }
                    .padding()
                    .padding(.top, 40)
                }
            }
        }
        .onAppear(perform: {
            subscribedItemDetailVM.loadItemData()
        })
        .sheet(item: $presentContent, content: { $0 })
    }
}

#if DEBUG

struct SubscribedItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SubscribedItemDetailView(subscribedItemDetailVM: demoSubscribedItemDetailVM)
                .environment(\.colorScheme, .light)

            SubscribedItemDetailView(subscribedItemDetailVM: demoSubscribedItemDetailVM)
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
