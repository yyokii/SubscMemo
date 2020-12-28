//
//  PaymentSummaryViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/12/28.
//

import Combine

final class PaymentSummaryViewModel: ObservableObject {
    @Published var subscRepository: SubscRepository = FirestoreSubscRepository()

    @Published var yearlyPayment: Int = 0
    @Published var monthlyPayment: Int = 0

    private var cancellables = Set<AnyCancellable>()

    init() {
        subscRepository.$items
            .map { items in
                items
                    .map {
                        $0.price * 12
                    }
                    .reduce(0) {
                        $0 + $1
                    }
            }
            .assign(to: \.yearlyPayment, on: self)
            .store(in: &cancellables)

        subscRepository.$items
            .map { items in
                items
                    .map {
                        $0.price
                    }
                    .reduce(0) {
                        $0 + $1
                    }
            }
            .assign(to: \.monthlyPayment, on: self)
            .store(in: &cancellables)
    }

    func addItem(item: SubscItem) {
        subscRepository.addItem(item)
    }
}

#if DEBUG

var demoPaymentSummaryVM: PaymentSummaryViewModel {

    let vm = PaymentSummaryViewModel()
    vm.yearlyPayment = 200
    vm.monthlyPayment =  100
    return vm
}

#endif
