//
//  DiscoverSubscView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/08.
//

import SwiftUI

struct DiscoverSubscView: View {

    var body: some View {
        Text("DiscoverSubscView")
    }
}

#if DEBUG

struct DiscoverSubscView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            DiscoverSubscView()
                .environment(\.colorScheme, .light)

            DiscoverSubscView()
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
