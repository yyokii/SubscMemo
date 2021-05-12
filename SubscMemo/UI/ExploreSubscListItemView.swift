//
//  ExploreSubscListItemView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/04/11.
//

import SwiftUI

/// 既存のサブスクリプションサービス探すときのアイテムView
struct ExploreSubscListItemView: View {

    let width: CGFloat = UIScreen.main.bounds.width/2 - 20

    var body: some View {
        return VStack(alignment: .leading) {

            HStack {
                Spacer()
                Text("カテゴリー")
                    .adaptiveFont(.matter, size: 8)
                    .lineLimit(1)
                    .foregroundColor(.appBlack)
            }
            .padding()

            Image(systemName: "scribble.variable")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.leading)

            Text("サブスクリプションサービス")
                .adaptiveFont(.matterSemiBold, size: 16)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .padding([.leading, .top])
                .foregroundColor(.appBlack)

            Text("せつめいせつめいせつめいせつめいせつめいせつめいせつめいせつめいせつめいせつめいせつめいせつめいせつめいせつめい")
                .adaptiveFont(.matter, size: 10)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(4)
                .padding([.leading, .top, .bottom])
                .foregroundColor(.appBlack)
        }
        .background(Color.white)
        .cornerRadius(30)
        .frame(width: width)
        .shadow(color: Color.gray, radius: 6, x: 0, y: 5)
    }
}

#if DEBUG

struct ExploreSubscListItemView_Previews: PreviewProvider {

    static var previews: some View {

        ExploreSubscListItemView()
            .environment(\.colorScheme, .light)

        ExploreSubscListItemView()
            .environment(\.colorScheme, .dark)
    }
}

#endif
