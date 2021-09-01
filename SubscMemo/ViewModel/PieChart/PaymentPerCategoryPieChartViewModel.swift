//
//  PaymentPerCategoryPieChartViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/07/08.
//

import Combine
import SwiftUI

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

    func arrangePieChartDatas(subscItems: [SubscribedItem], categories: [SubscCategory]) -> [PieChartData] {

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

        let firstColorHue = Double(datas.count) / 0.9
        let chartDatas = datas.keys
            .enumerated()
            .map { index, key in
                PieChartData(
                    data: Double(datas[key] ?? 0),
                    color: .init(hue: Double((index + 1))/firstColorHue),
                    label: key
                )
            }
            .sorted {
                $0.data > $1.data
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
