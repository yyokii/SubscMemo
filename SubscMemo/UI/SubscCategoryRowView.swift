//
//  SubscCategoryRowView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/11.
//

import SwiftUI

/// サブスクリプションサービスのカテゴリ一覧を表示するView
struct SubscCategoryRowView: View {

    @ObservedObject var subscCategoryRowVM = SubscCategoryRowViewModel()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .firstTextBaseline, spacing: 10) {
                ForEach(subscCategoryRowVM.categories) { category in
                    let searchResultVM = SearchResultViewModel(category: category)
                    NavigationLink(
                        destination: SearchResultView(vm: searchResultVM),
                        label: {
                            SubscCategoryItemView(category: category)
                                .padding(.bottom, 20)
                        })
                }
            }
        }
        .padding()
    }
}

struct SubscCategoryItemView: View {

    var category: SubscCategory

    var body: some View {
        return
            VStack {

                AsyncImage(url: URL(string: category.iconImageURL)!) {
                    Color.gray
                }
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding(.top)
                .shadow(radius: 0, x: 0.0, y: 0.0)

                Text(category.name)
                    .adaptiveFont(.matterMedium, size: 12)
                    .foregroundColor(.adaptiveBlack)
                    .frame(maxWidth: 120)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(10)

            }
            .frame(minWidth: 100, minHeight: 120)
    }
}

#if DEBUG
struct SubscCategoryRowView_Previews: PreviewProvider {
    static var previews: some View {

        SubscCategoryRowView(subscCategoryRowVM: demoSubscCategoryRowVM)
            .environment(\.colorScheme, .light)

        SubscCategoryRowView(subscCategoryRowVM: demoSubscCategoryRowVM)
            .environment(\.colorScheme, .dark)
    }
}
#endif
