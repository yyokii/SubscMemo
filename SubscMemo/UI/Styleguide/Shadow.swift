//
//  Shadow.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/07/10.
//

import SwiftUI

extension View {
    public func adaptiveShadow(radius: CGFloat = 8) -> some View {
        self.modifier(
            AdaptiveShadow(radius: radius)
        )
    }
}

struct AdaptiveShadow: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    let radius: CGFloat

    func body(content: Content) -> some View {
        content
            .shadow(color: colorScheme == .light ?  Color.gray : Color.gray, radius: radius, x: 0, y: 5)
    }
}

#if DEBUG

struct AdaptiveShadow_Previews: PreviewProvider {

    static var content: some View {
        NavigationView {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300, height: 300)
                .foregroundColor(.adaptiveWhite)
                .adaptiveShadow()
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
