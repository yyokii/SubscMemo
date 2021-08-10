//
//  ServiceIconImageView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/07/15.
//

import SwiftUI

struct ServiceIconImageView: View {
    let iconColor: Color?
    let serviceURL: String?
    let serviceName: String

    init(iconColor: Color? = nil, serviceURL: String?, serviceName: String) {
        self.iconColor = iconColor
        self.serviceURL = serviceURL
        self.serviceName = serviceName
    }

    var body: some View {
        if let serviceURL = serviceURL,
           !serviceURL.isEmpty,
           let faviconURL = makeFaviconURL(from: serviceURL) {
            ZStack {
                AsyncImageColor(url: faviconURL) {
                    Color.clear
                }
                Text(serviceName.first?.description ?? "")
                    .adaptiveFont(.matterSemiBold, size: 32)
                    .foregroundColor(.white)
            }
        } else {
            ZStack {
                Rectangle()
                    .foregroundColor(iconColor ?? .randomColor())
                Text(serviceName.first?.description ?? "")
                    .adaptiveFont(.matterSemiBold, size: 32)
                    .foregroundColor(.white)
            }
        }
    }

    func makeFaviconURL(from serviceURL: String) -> URL? {
        if let url = URL(string: serviceURL),
           let host = url.host {
            let faviconURL = URL(string: "https://www.google.com/s2/favicons")!
            return faviconURL.addQueryItem(name: "domain_url", value: host)
        } else {
            return nil
        }
    }
}

#if DEBUG

struct ServiceIconImageView_Previews: PreviewProvider {

    static var content: some View {
        NavigationView {
            VStack(spacing: 10) {
                // 非同期で取得
                ServiceIconImageView(serviceURL: "http://www.yahoo.com/",
                                     serviceName: "Abcde")
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)

                // ランダム色
                ServiceIconImageView(serviceURL: "",
                                     serviceName: "Bcdef")
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)

                // 指定色
                ServiceIconImageView(iconColor: Color.black,
                                     serviceURL: "",
                                     serviceName: "Bcdef")
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
