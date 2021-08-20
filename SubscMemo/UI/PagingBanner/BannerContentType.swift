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
    case announcement(imageURL: String)

    var id: Self { self }

    @ViewBuilder
    func getView() -> some View {
        switch self {
        case .advertisement:
            AdBannerView()
        case .announcement(let imageURL):
            ZStack {
                Color.green
                Text(imageURL)
            }
        }
    }
}
