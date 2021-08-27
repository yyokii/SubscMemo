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

    public func makeUIView(context: Context) -> UIViewType {
        let banner = GADBannerView(adSize: kGADAdSizeBanner)

        #if DEBUG
        banner.adUnitID = Identifiers.adUnitID
        #else
        banner.adUnitID = ""
        #endif

        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }

    public func updateUIView(_ uiView: UIViewType, context: Context) {}
}
