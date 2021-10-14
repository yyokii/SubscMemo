//
//  View+isHidden.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/10/14.
//

import SwiftUI

extension View {
    /// Hide or show the view based on a boolean value.
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder
    public func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
