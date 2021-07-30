//
//  AddSubscribedItemView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/07/08.
//

import SwiftUI

struct AddSubscribedItemView: View {
    var addAction: (() -> Void)?
    var searchAction: (() -> Void)?

    var body: some View {
        HStack {
            Button(action: {
                addAction?()
            }, label: {
                VStack(alignment: .center) {
                    Image(systemName: "plus.circle")
                    Text("追加する")
                        .foregroundColor(.adaptiveWhite)
                        .adaptiveFont(.matterSemiBold, size: 12)
                        .padding([.top], 1)

                }
                .frame(maxWidth: .infinity)
            })

            Button(action: {
                searchAction?()
            }, label: {
                VStack(alignment: .center) {
                    Image(systemName: "magnifyingglass")
                    Text("さがす")
                        .foregroundColor(.adaptiveWhite)
                        .adaptiveFont(.matterSemiBold, size: 12)
                        .padding([.top], 1)
                }
                .frame(maxWidth: .infinity)
            })
        }
        .frame(
            maxWidth: .infinity,
            minHeight: 0
        )
        .buttonStyle(ActionButtonStyle())
    }
}

#if DEBUG
struct AddSubscribedItemView_Previews: PreviewProvider {
    static var content: some View {
        NavigationView {
            AddSubscribedItemView()
        }
    }

    static var previews: some View {
        Group {
            content
                .environment(\.colorScheme, .light)

            content
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif
