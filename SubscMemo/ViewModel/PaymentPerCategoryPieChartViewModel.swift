//
//  PaymentPerCategoryPieChartViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/07/08.
//

import Combine

import Resolver

final class PaymentPerCategoryPieChartViewModel: ObservableObject {

    // Repository
    @Injected var subscribedServiceRepository: SubscribedServiceRepository

    @Published var subscCategoryRepository: SubscCategoryRepository = Resolver.resolve()
    @Published var pieChartDatas: [PieChartData] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        subscribedServiceRepository.$subscribedItems
            .combineLatest(subscCategoryRepository.$categories)
            .map { [weak self] (items, categories) in
                return self?.arrangePieChartDatas(subscItems: items, categories: categories) ?? []
            }
            .assign(to: \.pieChartDatas, on: self)
            .store(in: &cancellables)
    }

    private func arrangePieChartDatas(subscItems: [SubscribedItem], categories: [SubscCategory]) -> [PieChartData] {

        var datas: [String: Int] = [:]

        subscItems.forEach { item in
            let title: String? = categories
                .first {
                    $0.categoryID == item.categoryIDs[0]
                }?
                .name

            if let categoryTitle = title {
                let cycle = PaymentCycle.init(rawValue: item.cycle)
                let monthlyPayment = cycle?.perMonthValue(price: item.price) ?? 0
                datas[categoryTitle, default: 0] += monthlyPayment
            }
        }

        let chartDatas = datas.keys
            .enumerated()
            .map { key in
                PieChartData(
                    data: Double(datas[key.element] ?? 0),
                    label: key.element
                )
            }

        return chartDatas
    }
}

#if DEBUG

var demoPaymentPerCategoryPieChartVM: PaymentPerCategoryPieChartViewModel {

    let vm = PaymentPerCategoryPieChartViewModel()
    vm.pieChartDatas = demoPieChartDatas
    return vm
}

#endif
