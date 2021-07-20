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
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                ForEach(subscCategoryRowVM.categories) { category in
                    let searchResultVM = SearchResultViewModel(category: category)
                    NavigationLink(
                        destination: SearchResultView(vm: searchResultVM),
                        label: {
                            SubscCategoryItemView(category: category)
                        })
                }
            }
        }
    }
}

struct SubscCategoryItemView: View {

    var category: SubscCategory

    var body: some View {
        return
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color.white)
                        .adaptiveShadow()

                    AsyncImage(url: URL(string: category.iconImageURL)!) {
                        Color.gray
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                }
                .frame(width: 60, height: 60)

                Text(category.name)
                    .adaptiveFont(.matterMedium, size: 12)
                    .foregroundColor(.adaptiveBlack)
                    .frame(maxWidth: 120)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding([.top], 5)

            }
            .frame(minWidth: 100, minHeight: 150)
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
