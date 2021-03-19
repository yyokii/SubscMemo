//
//  ValidationStateView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/18.
//

import SwiftUI

struct ValidationStateView: View {

    @ObservedObject var vm = ValidationStateViewModel()

    var body: some View {
        vm.state.flatMap { state -> AnyView in

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
