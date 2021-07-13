//
//  SearchResultView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/27.
//

import SwiftUI

/// 検索結果画面
struct SearchResultView: View {
    @ObservedObject var vm: SearchResultViewModel
    @State var presentContent: PresentContent?
    var columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 2)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(vm.category.name)
                    .adaptiveFont(.matterSemiBold, size: 14)
                    .foregroundColor(.adaptiveBlack)

                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(vm.exploreSubscItemVMs) { vm in
                        let exploreSubscItemDetailVM = ExploreSubscItemDetailViewModel(serviceID: vm.item.serviceID)
                        NavigationLink(
                            destination: ExploreSubscItemDetailView(exploreSubscItemDetailVM: exploreSubscItemDetailVM),
                            label: {
                                ExploreSubscListItemView(vm: vm)
                            })
                    }
                }
                .padding([.top])
            }
        }
        .onAppear(perform: {
            vm.loadData()
        })
        .sheet(item: $presentContent, content: { $0 })
    }
}

#if DEBUG

struct SearchResultView_Previews: PreviewProvider {

    static var content: some View {
        NavigationView {
            SearchResultView(vm: demoSearchResultVM)
        }
    }

    static var previews: some View {
        Group {
            content
                .environment(\.colorScheme, .light)
            content
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
