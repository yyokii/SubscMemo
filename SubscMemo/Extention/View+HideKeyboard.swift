//
//  View+HideKeyboard.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/26.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
