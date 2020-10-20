//
//  Binding+IntToString.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/20.
//

import SwiftUI

extension Binding where Value == Int {
    func intToString(_ defaultValue: Int) -> Binding<String> {
        return Binding<String>(get: {
            return String(self.wrappedValue)
        }) { value in
            self.wrappedValue = Int(value) ?? defaultValue
        }
    }
}
