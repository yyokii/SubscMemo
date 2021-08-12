//
//  ExploreSubscView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/08.
//

import SwiftUI

struct ExploreSubscView: View {

    @ObservedObject var exploreSubscVM = ExploreSubscViewModel()
    @State var presentContent: PresentContent?
    var columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 2)

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    SubscCategoryRowView()
                }

                LazyVGrid(columns: columns) {
                    ForEach(exploreSubscVM.exploreSubscItemVMs) { vm in
                        let exploreSubscItemDetailVM = ExploreSubscItemDetailViewModel(serviceID: vm.item.serviceID)
                        NavigationLink(
                            destination: ExploreSubscItemDetailView(vm: exploreSubscItemDetailVM),
                            label: {
                                ExploreSubscListItemView(vm: vm)
                            })
                            .padding(.bottom, 20)
                    }
                }
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
            ExploreSubscView(exploreSubscVM: demoExploreSubscVM)
                .environment(\.colorScheme, .light)

            ExploreSubscView(exploreSubscVM: demoExploreSubscVM)
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
