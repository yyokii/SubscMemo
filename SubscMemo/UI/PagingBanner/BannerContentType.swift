//
//  BannerContentType.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/20.
//

import Foundation
import SwiftUI

enum BannerContentType {
    case advertisement
    case announcement(imageURL: URL)

    @ViewBuilder
    func getView() -> some View {
        switch self {
        case .advertisement:
            AdBannerView()
        case .announcement(let url):
            if let imageData: NSData = NSData(contentsOf: url) {
                if let image = UIImage(data: imageData as Data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            } else {
                Color.gray
            }

        }
    }
}
