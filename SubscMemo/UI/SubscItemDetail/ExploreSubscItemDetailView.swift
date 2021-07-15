//
//  ExploreSubscItemDetailView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/12.
//

import SwiftUI

struct ExploreSubscItemDetailView: View {
    @ObservedObject var vm: ExploreSubscItemDetailViewModel
    @State var presentContent: PresentContent?

    var body: some View {
        ZStack {
            // ベースカラー
            Color.adaptiveWhite
                .ignoresSafeArea()

            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            ServiceIconImageView(iconImageURL: vm.subscItem.iconImageURL, serviceName: vm.subscItem.serviceName)
                                .frame(width: 70, height: 70)
                                .cornerRadius(35)
                        }
                        .frame(maxWidth: .infinity)

                        ServiceNameView(
                            serviceName: vm.subscItem.serviceName,
                            serviceURL: vm.subscItem.serviceURL,
                            linkTapAction: { url in
                                presentContent = .safariView(url: url)
                            }
                        )
                        .padding([.top], 40)

                        Text(vm.subscItem.mainCategoryName)
                            .adaptiveFont(.matterSemiBold, size: 16)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(2)
                            .padding(.top)
                            .foregroundColor(.gray)

                        SubscPlanListView(plans: vm.plans)
                            .padding(.top, 20)

                        Text(vm.subscItem.description)
                            .adaptiveFont(.matterSemiBold, size: 16)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 40)
                            .foregroundColor(.gray)

                    }
                    .padding([.leading, .trailing, .bottom])

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
        .onAppear(perform: {
            vm.loadData()
        })
        .sheet(item: $presentContent, content: { $0 })
    }
}

#if DEBUG

struct SubscItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExploreSubscItemDetailView(vm: demoExploreSubscItemDetailVM)
                .environment(\.colorScheme, .light)

            ExploreSubscItemDetailView(vm: demoExploreSubscItemDetailVM)
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
