//
//  Color.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/04/09.
//

import SwiftUI

extension Color {

    /// lightモードの時に黒を基調としている場合に、映える色（白）を設定し且つカラーテーマに対応する
    public static let adaptiveWhite = Self {
        $0.userInterfaceStyle == .dark ? .appBlack : .white
    }

    /// lightモードの時に白を基調としている場合に、映える色（黒）を設定し且つカラーテーマに対応する
    public static let adaptiveBlack = Self {
        $0.userInterfaceStyle == .dark ? .white : .appBlack
    }

    public static let appBlack = hex(0x121212)
}

#if canImport(UIKit)

import UIKit

extension Color {

    public init(dynamicProvider: @escaping (UITraitCollection) -> Color) {
        self = Self(UIColor { UIColor(dynamicProvider($0)) })
    }

    public func inverted() -> Self {
        Self(UIColor(self).inverted())
    }
}

extension UIColor {

    public func inverted() -> Self {
        Self {
            self.resolvedColor(
                with: .init(userInterfaceStyle: $0.userInterfaceStyle == .dark ? .light : .dark)
            )
        }
    }
}

#endif
