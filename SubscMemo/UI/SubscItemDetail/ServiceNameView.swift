//
//  ServiceNameView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/03.
//

import SwiftUI

struct ServiceNameView: View {
    let serviceName: String
    let serviceURL: URL?
    let linkTapAction: ((URL) -> Void)?

    var body: some View {
        VStack(alignment: .leading) {
            Text(serviceName)
                .adaptiveFont(.matterSemiBold, size: 24)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .foregroundColor(.adaptiveBlack)

            if let serviceURL = serviceURL {
                Button(action: {
                    linkTapAction?(serviceURL)
                }, label: {
                    Image(systemName: "link.circle")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.adaptiveBlack)
                    Text(serviceURL.absoluteString)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(1)
                })
            }
        }
    }
}

#if DEBUG

struct ServiceNameView_Previews: PreviewProvider {
    static var content: some View {
        NavigationView {

            VStack(spacing: 50) {
                ServiceNameView(
                    serviceName: "サービス名",
                    serviceURL: URL(string: "https://www.google.com/aaaaaaaa")!,
                    linkTapAction: nil
                )

                ServiceNameView(
                    serviceName: "サービス名",
                    serviceURL: URL(string: "https://www.google.com/aaaaaaaaaaaaaaaaaaaaa")!,
                    linkTapAction: nil
                )
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
