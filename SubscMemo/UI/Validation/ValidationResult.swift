//
//  ValidationResult.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/19.
//

import SwiftUI

enum ValidationResult: Hashable {
    case valid(_ text: String)
    case invalid(_ message: String)
}
