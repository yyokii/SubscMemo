//
//  SubscItemListView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/10.
//

import SwiftUI

import Ballcap

struct SubscItemListView: View {

    enum Presentation: View, Hashable, Identifiable {
        var id: Self { self }
        case new
        case edit(item: SubscItem)
        var body: some View {
            switch self {
            case .new: return  AnyView(EditItemView(item: SubscItem()))
            case .edit(let item): return AnyView(EditItemView(item: item))
            }
        }
    }

    @State var presentation: Presentation?

    @State var user: AppUser?
    @State var items: [SubscItem] = []

    let dataSource: DataSource<SubscItem> = SubscItem
        .limit(to: 30)
        .dataSource()

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    VStack {
                        Text(item[\.title])
                    }
                    .contextMenu {
                        Button("編集") {
                            self.presentation = .edit(item: item)
                        }
                        Button("削除") {
                            item.delete()
                        }
                    }
                }
            }
            .onAppear(perform: {
                self.dataSource
                    .retrieve(from: { (_, snapshot, done) in
                        let item: SubscItem? = try? SubscItem(snapshot: snapshot)
                        done(item)
                    })
                    .onChanged({ (_, snapshot) in
                        self.items = snapshot.after
                    })
                    .listen()
            })
            .navigationBarTitle("SubscMemo")
            .navigationBarItems(trailing: Button("追加") {
                self.presentation = .new
            })
            .sheet(item: self.$presentation) { $0 }
        }
    }
}
