//
//  ValidationStateView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/18.
//

import SwiftUI

enum ValidationResult: Hashable {
    case valid(_ text: String)
    case invalid(_ message: String)
}

struct ValidationStateView: View {

    var state: ValidationResult?

    var body: some View {
        self.state.flatMap { state -> AnyView in

            switch state {
            case .invalid:
                return AnyView(Image(systemName: "xmark.circle")
                                .foregroundColor(Color.red))
            case .valid:
                return AnyView(Image(systemName: "checkmark.circle")
                                .foregroundColor(Color.green))

            }
        }
    }
}
