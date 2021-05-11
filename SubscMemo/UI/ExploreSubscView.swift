//
//  ExploreSubscView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/08.
//

import SwiftUI

struct ExploreSubscView: View {

    @State var presentContent: PresentContent?

    var body: some View {

        NavigationView {

            ScrollView {
                VStack(alignment: .leading) {
                    SubscCategoryRowView()
                }
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
            ExploreSubscView()
                .environment(\.colorScheme, .light)

            ExploreSubscView()
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
