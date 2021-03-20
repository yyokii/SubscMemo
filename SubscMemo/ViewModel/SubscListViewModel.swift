//
//  SubscListViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/11.
//

import Combine

import Resolver

final class SubscListViewModel: ObservableObject {
    @Published var subscRepository: SubscRepository = Resolver.resolve()
    @Published var subscCellViewModels = [SubscCellViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        subscRepository.$items
            .map { items in
                items.map { item in
                    SubscCellViewModel(item: item)
                }
            }
            .assign(to: \.subscCellViewModels, on: self)
            .store(in: &cancellables)
    }

    func addItem(item: SubscItem) {
        subscRepository.addItem(item)
    }
}

#if DEBUG

var demoSubscListVM: SubscListViewModel {

    let vm = SubscListViewModel()
    vm.subscCellViewModels = demoSubscCellVM
    return vm
}

#endif
