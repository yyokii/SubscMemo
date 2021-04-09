//
//  Color+Hex.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/04/09.
//

import SwiftUI

extension Color {
    public static func hex(_ hex: UInt) -> Self {
        Self(
            red: Double((hex & 0xff0000) >> 16) / 255,
            green: Double((hex & 0x00ff00) >> 8) / 255,
            blue: Double(hex & 0x0000ff) / 255,
            opacity: 1
        )
    }
}
