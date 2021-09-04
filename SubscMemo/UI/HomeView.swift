//
//  HomeView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/10.
//

import SwiftUI

struct HomeView: View {
    @Binding var tabSelection: MainTabView.TabItem
    @StateObject var homeVM = HomeViewModel()
    @State var presentContent: PresentContent?

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("支払い額の概算")
                            .adaptiveFont(.matterSemiBold, size: 12)
                            .padding()

                        PaymentSummaryView()
                            .padding()

                        AdBannerView()
                            .aspectRatio(6.4, contentMode: .fit)

                        Text("マイデータ")
                            .adaptiveFont(.matterSemiBold, size: 12)
                            .padding()

                        // グラフデータ
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .firstTextBaseline, spacing: 10) {
                                let width = (geo.size.width - 40) > 0 ? geo.size.width - 40 : 0
                                CategoryPieChartView()
                                    .frame(width: width)
                                PaymentPerCategoryPieChartView()
                                    .frame(width: width)
                            }
                            .padding()
                        }

                        Text("登録済みのサービス")
                            .adaptiveFont(.matterSemiBold, size: 12)
                            .padding()

                        if homeVM.subscribedItemVMs.isEmpty {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("利用しているサービスを追加しましょう！")
                                Text("「さがす」からサービスを検索して簡単に追加できます😊")
                                Text("「追加する」からあなた独自のものを追加することもできます👍")
                            }
                            .adaptiveFont(.matterMedium, size: 10)
                            .padding()
                        }

                        ForEach(homeVM.subscribedItemVMs) { vm in
                            let iconColor = Color.randomColor()
                            let subscribedItemDetailVM = SubscribedItemDetailViewModel(dataID: vm.item.id)
                            NavigationLink(
                                destination: SubscribedItemDetailView(vm: subscribedItemDetailVM, iconColor: iconColor),
                                label: {
                                    SubscribedItemView(vm: vm, iconColor: iconColor)
                                        .padding()
                                })
                        }

                        HStack {
                            Spacer()
                            AddSubscribedItemView {
                                presentContent = .createCustomSubscItem
                            } searchAction: {
                                tabSelection = .search
                            }
                            Spacer()
                        }
                        .padding([.horizontal], 8)
                        .padding([.bottom], 48)
                    }
                }
                .navigationBarTitle("マイサブスク")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(
                            destination: SettingsView(),
                            label: {
                                Image(systemName: "gearshape")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            })
                    }
                }
                .sheet(item: $presentContent, content: { $0 })
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

enum InputError: Error {
    case empty
}

#if DEBUG

struct HomeView_Previews: PreviewProvider {

    static var previews: some View {
        return
            Group {
                HomeView(tabSelection: .constant(.home), homeVM: demoHomeVM)
                    .environment(\.colorScheme, .light)

                HomeView(tabSelection: .constant(.home), homeVM: demoHomeVM)
                    .environment(\.colorScheme, .dark)
            }
    }
}

#endif
