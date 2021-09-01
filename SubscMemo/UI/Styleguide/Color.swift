//
//  Color.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/04/09.
//

import SwiftUI

extension Color {

    /// lightモードの場合に、白を設定し且つカラーテーマに対応する
    public static let adaptiveWhite = Self {
        $0.userInterfaceStyle == .dark ? appBlack : .white
    }

    /// lightモードの場合に、黒を設定し且つカラーテーマに対応する
    public static let adaptiveBlack = Self {
        $0.userInterfaceStyle == .dark ? .white : appBlack
    }

    public static let appBlack = hex(0x2C2C2E)

    public static let defaultSaturation: Double = 0.9
    public static let defaultBrightness: Double = 0.9

    /// 引数で与えられた色相とアプリ固有の彩度、明度を使用して色を生成する
    init(hue: Double) {
        self.init(hue: hue,
                  saturation: Color.defaultSaturation,
                  brightness: Color.defaultBrightness)
    }

    /// 任意のトーンの色をランダムに生成する
    public static func randomColor(saturation: Double = defaultSaturation, brightness: Double = defaultBrightness) -> Self {
        let hueValue = Double.random(in: 0...1)
        return Color.init(hue: hueValue, saturation: saturation, brightness: brightness)
    }
}

#if canImport(UIKit)

import UIKit

extension Color {

    public init(dynamicProvider: @escaping (UITraitCollection) -> Color) {
        self = Self(UIColor { UIColor(dynamicProvider($0)) })
    }

    public static let placeholderGray = Color(UIColor.placeholderText)
}

#endif

#if DEBUG

struct DemoColorView_Previews: PreviewProvider {

    static var content: some View {
        NavigationView {
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.adaptiveBlack)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.adaptiveWhite)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.appBlack)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.placeholderGray)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.randomColor())
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.randomColor())
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.randomColor())
            }
            .shadow(radius: 10)
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
