//
//  ExploreSubscView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/08.
//

import SwiftUI

struct ExploreSubscView: View {
    @StateObject var vm = ExploreSubscViewModel()
    @State var presentContent: PresentContent?
    var columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 2)

    var body: some View {
        NavigationView {
            ScrollView {
                SearchBarView(text: $vm.searchText)
                    .padding(.horizontal, 10)

                LazyVGrid(columns: columns) {
                    ForEach(vm.displayVMs) { vm in
                        let exploreSubscItemDetailVM = ExploreSubscItemDetailViewModel(serviceID: vm.item.serviceID)
                        NavigationLink(
                            destination: ExploreSubscItemDetailView(vm: exploreSubscItemDetailVM),
                            label: {
                                ExploreSubscListItemView(vm: vm)
                            })
                            .padding(.bottom, 20)
                    }
                }
                .padding(.top, 10)
            }
            .navigationBarTitle("見つける")
            .sheet(item: $presentContent, content: { $0 })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#if DEBUG

struct ExploreSubscView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            ExploreSubscView(vm: demoExploreSubscVM)
                .environment(\.colorScheme, .light)

            ExploreSubscView(vm: demoExploreSubscVM)
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
