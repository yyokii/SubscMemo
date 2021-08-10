//
//  ExploreSubscListItemView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/04/11.
//

import SwiftUI

/// 既存のサブスクリプションサービス探すときのアイテムView
struct ExploreSubscListItemView: View {

    @ObservedObject var vm: ExploreSubscItemViewModel

    let width: CGFloat = UIScreen.main.bounds.width/2 - 20

    var body: some View {
        return VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(vm.item.mainCategoryName)
                    .adaptiveFont(.matter, size: 8)
                    .lineLimit(1)
                    .foregroundColor(.adaptiveBlack)
            }
            .padding()

            ServiceIconImageView(serviceURL: vm.item.iconImageURL,
                                 serviceName: vm.item.serviceName)
                .frame(width: 50, height: 50)
                .cornerRadius(25)
                .padding(.leading)

            Text(vm.item.serviceName)
                .adaptiveFont(.matterSemiBold, size: 16)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .padding([.leading, .top])
                .foregroundColor(.adaptiveBlack)

            Text(vm.item.description)
                .adaptiveFont(.matter, size: 10)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(4)
                .padding([.leading, .top, .bottom])
                .foregroundColor(.adaptiveBlack)
        }
        .background(Color.adaptiveWhite)
        .cornerRadius(30)
        .frame(width: width)
        .adaptiveShadow()
    }
}

#if DEBUG

struct ExploreSubscListItemView_Previews: PreviewProvider {

    static var content: some View {
        NavigationView {
            ExploreSubscListItemView(vm: demoExploreSubscItemVMs[0])
        }
    }

    static var previews: some View {

        content
            .environment(\.colorScheme, .light)

        content
            .environment(\.colorScheme, .dark)
    }
}

#endif
