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
            return HStack {
                Image(systemName: "xmark.circle")
                    .foregroundColor(Color.red)
                Text(message)
            }
        case .valid(let message):
            return HStack {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(Color.green)
                Text(message)
            }
        }
    }
}

#if DEBUG

struct ValidationStateView_Previews: PreviewProvider {
    
    static let validVM: ValidationStateViewModel = {
        let vm = ValidationStateViewModel()
        vm.state = .valid("OK!")
        return vm
    }()
    
    static let invalidVM: ValidationStateViewModel = {
        let vm = ValidationStateViewModel()
        vm.state = .invalid("No...")
        return vm
    }()
    
    static var previews: some View {
        VStack {
            ValidationStateView(vm: invalidVM)
            ValidationStateView(vm: validVM)
        }
    }
}

#endif
