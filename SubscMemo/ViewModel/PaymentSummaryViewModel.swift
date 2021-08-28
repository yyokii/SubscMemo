//
//  PaymentSummaryViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/12/28.
//

import Combine
import WidgetKit

import Resolver

final class PaymentSummaryViewModel: ObservableObject {
    // Data Store
    let dataStore: KeyValueStore

    // Repository
    @Injected var subscribedServiceRepository: SubscribedServiceRepository

    @Published var yearlyPayment: Int = 0
    @Published var monthlyPayment: Int = 0

    private var cancellables = Set<AnyCancellable>()

    init(userDataStore: KeyValueStore = UserDefaults.init(suiteName: UserDefaultSuiteName.mysubscmemo.rawValue)!) {
        dataStore = userDataStore

        subscribedServiceRepository.$subscribedItems
            .map { items in
                items
                    .map {
                        let cycle = PaymentCycle.init(rawValue: $0.cycle)
                        return cycle?.perMonthValue(price: $0.price) ?? 0
                    }
                    .reduce(0) { res, data in
                        res + data
                    }
            }
            .handleEvents(receiveOutput: { [weak self] data in
                self?.dataStore.set(data, forKey: .cachedMonthlyPayment)
                WidgetCenter.shared.reloadAllTimelines()
            })
            .assign(to: \.monthlyPayment, on: self)
            .store(in: &cancellables)

        subscribedServiceRepository.$subscribedItems
            .map { items in
                items
                    .map {
                        let cycle = PaymentCycle.init(rawValue: $0.cycle)
                        return cycle?.perYearValue(price: $0.price) ?? 0
                    }
                    .reduce(0) { res, data in
                        res + data
                    }
            }
            .handleEvents(receiveOutput: { [weak self] data in
                self?.dataStore.set(data, forKey: .cachedYearlyPayment)
                WidgetCenter.shared.reloadAllTimelines()
            })
            .assign(to: \.yearlyPayment, on: self)
            .store(in: &cancellables)
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
