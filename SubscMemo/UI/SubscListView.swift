//
//  SubscListView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/10.
//

import SwiftUI

struct SubscListView: View {
    @ObservedObject var subscListVM = SubscListViewModel()

    @State var presentContent: PresentContent?

    var body: some View {
        NavigationView {

            ScrollView {
                VStack(alignment: .leading) {

                    Text("新着")
                        .padding()

                    Divider()

                    ExploreSubscRowView()

                    Text("おすすめ")
                        .padding()

                    Divider()
                    ForEach(0..<10) {
                        Text("demo_\($0)")
                            .padding()
                    }
                }
            }
            .navigationBarTitle("App")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {

                    NavigationLink(
                        destination:
                            SearchSubscView(),
                        label: {
                            Image(systemName: "magnifyingglass.circle")
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

struct SubscCell: View {
    @ObservedObject var subscCellVM: SubscCellViewModel
    var onCommit: (Result<SubscItem, InputError>) -> Void = { _ in }

    var body: some View {
        VStack {
            Text(subscCellVM.item.title)
        }
    }
}
