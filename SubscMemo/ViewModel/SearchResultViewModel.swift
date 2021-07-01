//
//  SearchResultViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/29.
//

import Combine

import Resolver

final class SearchResultViewModel: ObservableObject {
    @Published var alertProvider = AlertProvider()
    var category: SubscCategory!
    @Published var exploreSubscRepository: ExploreSubscRepository = Resolver.resolve()
    @Published var exploreSubscItemVMs = [ExploreSubscItemViewModel]()
    private var cancellables = Set<AnyCancellable>()

    init(category: SubscCategory) {
        self.category = category

        alertProvider.objectWillChange
            .sink { [weak self] (_) in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }

    func loadData() {
        exploreSubscRepository.loadData(with: [category])
            .map { items in
                items.map { ExploreSubscItemViewModel(item: ExploreSubscItemViewData.translate(from: $0)) }
            }
            .sink(receiveCompletion: { [weak self] completion in

                switch completion {
                case .failure:
                    self?.alertProvider.showErrorAlert(message: nil)
                case .finished:
                    break
                }

            }, receiveValue: { datas in
                self.exploreSubscItemVMs = datas
            })
            .store(in: &cancellables)
    }
}

#if DEBUG

var demoSearchResultVM: SearchResultViewModel {
    let vm = SearchResultViewModel(category: demoSubscCategories[0])
    vm.exploreSubscItemVMs = demoExploreSubscItemVMs
    return vm
}

#endif
