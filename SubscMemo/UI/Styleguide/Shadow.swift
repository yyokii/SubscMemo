//
//  Shadow.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/07/10.
//

import SwiftUI

extension View {
    public func adaptiveShadow() -> some View {
        self.modifier(
            AdaptiveShadow()
        )
    }
}

#warning("カラーテーマ対応する")
struct AdaptiveShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.gray, radius: 8)
    }
}
