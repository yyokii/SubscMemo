//
//  ExploreSubscItemDetailView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/12.
//

import SwiftUI

struct ExploreSubscItemDetailView: View {
    @ObservedObject var exploreSubscItemDetailVM: ExploreSubscItemDetailViewModel
    @State var presentContent: PresentContent?

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

                            ServiceNameView(
                                serviceName: exploreSubscItemDetailVM.subscItem .serviceName,
                                serviceURL: exploreSubscItemDetailVM.subscItem.serviceURL,
                                linkTapAction: { url in
                                    presentContent = .safariView(url: url)
                                }
                            )

                            Text(exploreSubscItemDetailVM.subscItem.mainCategoryName)
                                .adaptiveFont(.matterSemiBold, size: 16)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(2)
                                .padding(.top)
                                .foregroundColor(.gray)

                            SubscPlanListView(plans: exploreSubscItemDetailVM.plans)
                                .padding(.top, 20)

                            Text(exploreSubscItemDetailVM.subscItem.description)
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
        .sheet(item: $presentContent, content: { $0 })
    }
}

#if DEBUG

struct SubscItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExploreSubscItemDetailView(exploreSubscItemDetailVM: demoExploreSubscItemDetailVM)
                .environment(\.colorScheme, .light)

            ExploreSubscItemDetailView(exploreSubscItemDetailVM: demoExploreSubscItemDetailVM)
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
