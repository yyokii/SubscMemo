//
//  AdaptiveSize.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/04/08.
//

import SwiftUI

public enum AdaptiveSize {
    case small
    case medium
    case large

    public func pad(_ other: CGFloat, by scale: CGFloat = 1) -> CGFloat {
        self.padding * scale + other
    }

    public var padding: CGFloat {
        switch self {
        case .small:
            return 0
        case .medium:
            return 4
        case .large:
            return 8
        }
    }

    public var buttonSize: CGFloat {
        switch self {
        case .small:
            return 200
        case .medium:
            return 300
        case .large:
            return 300
        }
    }
}

extension EnvironmentValues {
    public var adaptiveSize: AdaptiveSize {
        get { self[AdaptiveSizeKey.self] }
        set { self[AdaptiveSizeKey.self] = newValue }
    }
}

private struct AdaptiveSizeKey: EnvironmentKey {
    static var defaultValue: AdaptiveSize {
        switch UIScreen.main.bounds.width {
        case ..<375:
            return .small
        case ..<428:
            return .medium
        default:
            return .large
        }
    }
}
