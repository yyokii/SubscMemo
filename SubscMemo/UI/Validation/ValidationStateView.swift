//
//  ValidationStateView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/18.
//

import SwiftUI

struct ValidationStateView: View {
    @ObservedObject var vm: ValidationStateViewModel

    var body: some View {
        vm.state.flatMap {
            view(with: $0)
        }
        .adaptiveFont(.matterMedium, size: 12)
    }

    func view(with state: ValidationStateViewModel.ValidationResult) -> some View {
        switch state {
        case .invalid(let message):
            return HStack(alignment: .top) {
                Image(systemName: "xmark.circle")
                    .foregroundColor(Color.red)
                Text(message)
            }
            .adaptiveFont(.matterMedium, size: 10)
        case .valid(let message):
            return HStack(alignment: .top) {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(Color.green)
                Text(message)
            }
            .adaptiveFont(.matterMedium, size: 10)
        }
    }
}

#if DEBUG

struct ValidationStateView_Previews: PreviewProvider {

    static let validVM: ValidationStateViewModel = {
        let vm = ValidationStateViewModel()
        vm.state = .valid("Nice\nOK!\nCool")
        return vm
    }()

    static let invalidVM: ValidationStateViewModel = {
        let vm = ValidationStateViewModel()
        vm.state = .invalid("No...")
        return vm
    }()

    static var previews: some View {
        VStack(spacing: 20) {
            ValidationStateView(vm: invalidVM)
            ValidationStateView(vm: validVM)
        }
    }
}

#endif
