//
//  ServiceMemoView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/03.
//

import SwiftUI

struct ServiceMemoView: View {
    @Binding var memo: String

    var body: some View {
        TextEditor(text: _memo)
            .lineSpacing(12)
            .border(Color.adaptiveBlack, width: 1)
            .foregroundColor(Color.adaptiveBlack)
            .adaptiveFont(.matterMedium, size: 12)
    }
}

#if DEBUG

struct ServiceMemoView_Previews: PreviewProvider {
    static var content: some View {
        NavigationView {
            ServiceMemoView(memo: .constant("めもめもめもめもめもめもめもめもめもめもめもめもめもめもめもめもめもめもめもめもめもめもめもめもめもめもめも"))
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
