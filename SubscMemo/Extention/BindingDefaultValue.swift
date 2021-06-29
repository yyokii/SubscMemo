//
//  BindingDefaultValue.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/12.
//

import SwiftUI

func ?? <T>(lhs: Binding<T?>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
