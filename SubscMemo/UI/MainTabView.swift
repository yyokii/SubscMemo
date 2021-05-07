//
//  MainTabView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/08.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "1.circle.fill")
                    Text("🍌🍌")
                }

            DiscoverSubscView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("🍏🍏")
                }
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
