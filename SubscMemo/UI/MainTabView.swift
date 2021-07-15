//
//  MainTabView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/08.
//

import SwiftUI

struct MainTabView: View {
    enum TabItem {
        case home
        case search
    }
    @State var selectedItem: TabItem = .home

    var body: some View {
        TabView(selection: $selectedItem) {
            HomeView(tabSelection: $selectedItem)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("マイページ")

                }
                .tag(TabItem.home)

            ExploreSubscView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("さがす")
                }
                .tag(TabItem.search)
        }
        .font(.headline)
    }
}

#if DEBUG

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            MainTabView()
                .environment(\.colorScheme, .light)

            MainTabView()
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
