//
//  Button.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/04/09.
//

import SwiftUI

public struct ActionButtonStyle: ButtonStyle {
    @Environment(\.adaptiveSize) var adaptiveSize
    let backgroundColor: Color
    let foregroundColor: Color
    let isActive: Bool
    let isAdaptiveSize: Bool

    public init(
        backgroundColor: Color = .adaptiveBlack,
        foregroundColor: Color = .adaptiveWhite,
        isAdaptiveSize: Bool = true,
        isActive: Bool = true
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.isActive = isActive
        self.isAdaptiveSize = isAdaptiveSize
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .foregroundColor(
                self.foregroundColor
                    .opacity(!configuration.isPressed ? 1 : 0.5)
            )
            .padding([.top, .bottom], 20)
            .background(
                RoundedRectangle(cornerRadius: 13)
                    .fill(
                        self.backgroundColor
                            .opacity(self.isActive && !configuration.isPressed ? 1 : 0.5)
                    )
                    .if(isAdaptiveSize) { view in
                        view
                            .frame(width: adaptiveSize.buttonSize)
                    }
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .adaptiveFont(.matterMedium, size: 16)
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        let view = NavigationView {
            VStack {
                Section(header: Text("Active")) {
                    Button("ぼたん") {}
                    NavigationLink("りんく", destination: EmptyView())
                }
                .buttonStyle(ActionButtonStyle())

                Section(header: Text("In-active")) {
                    Button("ぼたん") {}
                    NavigationLink("りんく", destination: EmptyView())
                }
                .buttonStyle(ActionButtonStyle(isActive: false))
            }
        }

        return Group {
            view
                .environment(\.colorScheme, .light)
            view
                .environment(\.colorScheme, .dark)
        }
    }
}
