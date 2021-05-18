//
//  HomeView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/10.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var subscListVM = HomeViewModel()

    @State var presentContent: PresentContent?

    var body: some View {
        NavigationView {

            ScrollView {
                VStack(alignment: .leading) {

                    PaymentSummaryView()
                        .padding()

                    CategoryPieChartView()
                        .padding()

                    Text("登録済みのサービス")
                        .adaptiveFont(.matterSemiBold, size: 12)
                        .padding()

                    ForEach(0..<10) { _ in

                        SubscribedItemView()
                            .padding()
                    }
                }
            }
            .navigationBarTitle("App")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {

                    NavigationLink(
                        destination:
                            SettingsView(),
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
    var onCommit: (Result<SubscribedItem, InputError>) -> Void = { _ in }

    var body: some View {
        VStack {
            Text(subscCellVM.item.name)
        }
    }
}

#if DEBUG

struct HomeView_Previews: PreviewProvider {

    static var previews: some View {
        return
            Group {
                HomeView()
                    .environment(\.colorScheme, .light)

                HomeView()
                    .environment(\.colorScheme, .dark)
            }
    }
}

#endif
