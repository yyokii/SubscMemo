//
//  HomeView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/10.
//

import SwiftUI

struct HomeView: View {
    @Binding var tabSelection: MainTabView.TabItem
    @ObservedObject var homeVM = HomeViewModel()
    @State var presentContent: PresentContent?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    PaymentSummaryView()
                        .padding()

                    CategoryPieChartView()
                        .padding()

                    Text("登録済みのサービス")
                        .adaptiveFont(.matterSemiBold, size: 12)
                        .padding()

                    ForEach(homeVM.subscribedItemVMs) { vm in
                        let subscribedItemDetailVM = SubscribedItemDetailViewModel(serviceID: vm.item.serviceID)
                        NavigationLink(
                            destination: SubscribedItemDetailView(subscribedItemDetailVM: subscribedItemDetailVM),
                            label: {
                                SubscribedItemView(subscribedItemVM: vm)
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
            .navigationBarTitle("App")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentContent = .userSetting
                    }, label: {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                    })
                }
            }
            .sheet(item: $presentContent, content: { $0 })
        }
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
