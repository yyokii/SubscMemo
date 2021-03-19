//
//  ValidationStateViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/20.
//

import Combine

final class ValidationStateViewModel: ObservableObject {

    enum ValidationResult: Hashable {
        case valid(_ text: String)
        case invalid(_ message: String)
    }

    @Published var state: ValidationResult?
}
