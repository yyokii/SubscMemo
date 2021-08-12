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
        VStack(alignment: .leading) {
            Text(vm.item.mainCategoryName)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .adaptiveFont(.matter, size: 8)
                .lineLimit(1)
                .foregroundColor(.adaptiveBlack)
                .padding(.trailing)
                .padding(.top, 10)

            ServiceIconImageView(serviceURL: vm.item.serviceURL,
                                 serviceName: vm.item.serviceName)
                .frame(width: 50, height: 50)
                .cornerRadius(25)
                .padding(.leading)
                .padding(.top, 30)

            Text(vm.item.serviceName)
                .adaptiveFont(.matterSemiBold, size: 16)
                .multilineTextAlignment(.leading)
                .frame(height: 70)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .padding(.horizontal)
                .foregroundColor(.adaptiveBlack)

            Group {
                Text(vm.item.description)
                    .adaptiveFont(.matter, size: 10)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.adaptiveBlack)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(4)
            }
            .frame(height: 50)
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 30)
        }
        .frame(width: width)
        .background(Color.adaptiveWhite)
        .cornerRadius(30)
        .adaptiveShadow()
    }
}

#if DEBUG

struct ExploreSubscListItemView_Previews: PreviewProvider {

    static var content: some View {
        NavigationView {
            HStack {
                ExploreSubscListItemView(vm: demoExploreSubscItemVMs[0])
                ExploreSubscListItemView(vm: demoExploreSubscItemVMs[1])
            }
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
