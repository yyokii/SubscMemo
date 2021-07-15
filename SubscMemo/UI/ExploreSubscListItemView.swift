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
                    .foregroundColor(.appBlack)
            }
            .padding()

            ServiceIconImageView(iconImageURL: vm.item.iconImageURL, serviceName: vm.item.serviceName)
                .frame(width: 50, height: 50)
                .cornerRadius(25)
                .padding(.leading)

            Text(vm.item.serviceName)
                .adaptiveFont(.matterSemiBold, size: 16)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .padding([.leading, .top])
                .foregroundColor(.appBlack)

            Text(vm.item.description)
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

        ExploreSubscListItemView(vm: demoExploreSubscItemVMs[0])
            .environment(\.colorScheme, .light)

        ExploreSubscListItemView(vm: demoExploreSubscItemVMs[1])
            .environment(\.colorScheme, .dark)
    }
}

#endif
