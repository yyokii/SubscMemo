//
//  AdBannerView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/18.
//

import SwiftUI

import GoogleMobileAds

/*
 About Admob Banner : https://developers.google.com/admob/ios/banner
 */
struct AdBannerView: UIViewRepresentable {
    typealias UIViewType = GADBannerView

    @Binding var didReceiveAd: Bool?

    public func makeUIView(context: Context) -> UIViewType {
        let banner = GADBannerView(adSize: GADAdSizeBanner)
        banner.adUnitID = Identifiers.adUnitID
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.delegate = context.coordinator
        banner.load(GADRequest())

        return banner
    }

    public func updateUIView(_ uiView: UIViewType, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Self.Coordinator(parent: self)
    }
}

// MARK: Coordinator

extension AdBannerView {
    final class Coordinator: NSObject, GADBannerViewDelegate {
        private let parent: AdBannerView

        init(parent: AdBannerView) {
            self.parent = parent
        }

        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            parent.didReceiveAd = true
        }

        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            parent.didReceiveAd = false
        }
    }
}
