//
//  SearchSubscView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/04/05.
//

import SwiftUI

struct SearchSubscView: View {

    @ObservedObject var searchSubscVM = SearchSubscViewModel()

    @State private var searchText = ""

    var body: some View {

        VStack(alignment: .leading) {
            SearchBar(text: $searchText)
                .padding(10)

            Text("カテゴリー")
                .padding(.horizontal, 15)

            List(searchSubscVM.categories) { item in

                Text(item.name)
                    .padding(10)
                    .padding(.horizontal, 10)
            }
        }
    }
}

#if DEBUG

struct SearchSubscView_Previews: PreviewProvider {
    static var previews: some View {
        SearchSubscView(searchSubscVM: demoSearchSubscVM)
    }
}

#endif
