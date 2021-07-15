//
//  ServiceIconImageView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/07/15.
//

import SwiftUI

struct ServiceIconImageView: View {
    let iconImageURL: String?
    let serviceName: String

    var body: some View {
        if let iconImageURL = iconImageURL, !iconImageURL.isEmpty {
            AsyncImage(url: URL(string: iconImageURL)!) {
                Color.clear
            }
        } else {
            ZStack {
                Rectangle()
                    .foregroundColor(.randomColor())
                Text(serviceName.first?.description ?? "")
                    .adaptiveFont(.matterSemiBold, size: 32)
                    .foregroundColor(.white)
            }
        }
    }
}

#if DEBUG

struct ServiceIconImageView_Previews: PreviewProvider {

    static var content: some View {
        NavigationView {
            VStack(spacing: 10) {
                ServiceIconImageView(iconImageURL: "https://via.placeholder.com/150", serviceName: "Abcde")
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)

                ServiceIconImageView(iconImageURL: "", serviceName: "Bcdef")
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
            }
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
