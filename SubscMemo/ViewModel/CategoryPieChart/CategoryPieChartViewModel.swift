//
//  CategoryPieChartViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/08.
//

import Combine

import Resolver

final class CategoryPieChartViewModel: ObservableObject {

    @Published var subscRepository: SubscRepository = Resolver.resolve()
    @Published var subscCategoryRepository: SubscCategoryRepository = Resolver.resolve()

    @Published var pieChartDatas: [PieChartData] = []

    private var cancellables = Set<AnyCancellable>()

    init() {

        subscRepository.$items
            .combineLatest(subscCategoryRepository.$categories)
            .map { [weak self] (items, categories) in

                return self?.arrangePieChartDatas(subscItems: items, categories: categories) ?? []
            }
            .assign(to: \.pieChartDatas, on: self)
            .store(in: &cancellables)
    }

    private func arrangePieChartDatas(subscItems: [SubscItem], categories: [SubscCategory]) -> [PieChartData] {

        var datas: [String: Int] = [:]

        subscItems.forEach { item in
            let title: String? = categories
                .first {
                    $0.categoryID == item.mainCategoryID
                }?
                .name

            if let categoryTitle = title {
                datas[categoryTitle, default: 0] += 1
            }
        }

        let chartDatas = datas.keys
            .enumerated()
            .map { key in
                PieChartData(data: Double(datas[key.element] ?? 0),
                             color: pieChartColors[key.offset],
                             label: key.element)
            }

        return chartDatas
    }
}

#if DEBUG

var demoCategoryPieChartVM: CategoryPieChartViewModel {

    let vm = CategoryPieChartViewModel()
    vm.pieChartDatas = demoPieChartDatas
    return vm
}

#endif
