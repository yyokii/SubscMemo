//
//  JapaneseFontText.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/07/11.
//

import SwiftUI

extension Text {

    public func ctFont(_ ctFont: CTFont) -> some View {
        let descent = CTFontGetDescent(ctFont)
        return self.font(.init(ctFont))
            .baselineOffset(descent)
            .offset(y: descent / 2)
    }

    public func adaptiveFont(
        _ name: FontName,
        size: CGFloat,
        configure: @escaping (Font) -> Font = { $0 }
    ) -> some View {
        return AdaptiveFontText(
            textView: self,
            name: name.rawValue,
            size: size
        )
    }

    private struct AdaptiveFontText: View {
        @Environment(\.adaptiveSize) var adaptiveSize

        let textView: Text
        let name: String
        let size: CGFloat

        var body: some View {
            let ctFont = CTFontCreateWithName(
                name as CFString,
                size + adaptiveSize.padding,
                nil
            )
            let descent = CTFontGetDescent(ctFont)

            return textView.font(.init(ctFont))
                .baselineOffset(descent)
                .offset(y: descent / 2)
        }
    }

}
