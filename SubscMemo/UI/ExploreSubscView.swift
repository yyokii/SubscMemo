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

                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(exploreSubscVM.exploreSubscItemVMs) { vm in
                        ExploreSubscListItemView(exploreSubscItemVM: vm)
                    }
                }
                .font(.largeTitle)
            }
            .navigationBarTitle("見つける")
            .sheet(item: $presentContent, content: { $0 })
        }
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
