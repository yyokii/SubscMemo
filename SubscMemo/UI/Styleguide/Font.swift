//
//  Font.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/04/07.
//

import SwiftUI
import Tagged

public typealias FontName = Tagged<Font, String>

extension FontName {
    public static let matter: Self = "HiraginoSans-W3"
    public static let matterMedium: Self = "HiraginoSans-W3"
    public static let matterSemiBold: Self = "HiraginoSans-W6"
}

extension Font {
    public static func custom(_ name: FontName, size: CGFloat) -> Self {
        .custom(name.rawValue, size: size)
    }
}

extension View {
    public func adaptiveFont(
        _ name: FontName,
        size: CGFloat,
        configure: @escaping (Font) -> Font = { $0 }
    ) -> some View {
        self.modifier(AdaptiveFont(name: name.rawValue, size: size, configure: configure))
    }
}

private struct AdaptiveFont: ViewModifier {
    @Environment(\.adaptiveSize) var adaptiveSize

    let name: String
    let size: CGFloat
    let configure: (Font) -> Font

    func body(content: Content) -> some View {
        content.font(self.configure(.custom(self.name, size: self.size + self.adaptiveSize.padding)))
    }
}

#if DEBUG
struct Font_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(
                    [10, 12, 14, 16, 18, 20, 24, 32, 60].reversed(),
                    id: \.self
                ) { fontSize in
                    Text("あぷりけーしょん")
                        .adaptiveFont(.matterMedium, size: CGFloat(fontSize))
                }
            }
        }

        Group {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(
                    [10, 12, 14, 16, 18, 20, 24, 32, 60].reversed(),
                    id: \.self
                ) { fontSize in
                    Text("あぷりけーしょん")
                        .adaptiveFont(.matterSemiBold, size: CGFloat(fontSize))
                }
            }
        }

    }
}
#endif
