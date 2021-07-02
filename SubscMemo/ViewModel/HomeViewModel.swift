//
//  HomeViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/11.
//

import Combine

import Resolver

final class HomeViewModel: ObservableObject {
    @Published var subscribedServiceRepository: SubscribedServiceRepository = Resolver.resolve()
    @Published var subscribedItemVMs = [SubscribedItemViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        subscribedServiceRepository.$joinedDatas
            .map { items in
                items.map { SubscribedItemViewModel(item: $0) }
            }
            .assign(to: \.subscribedItemVMs, on: self)
            .store(in: &cancellables)
    }
}

#if DEBUG

var demoHomeVM: HomeViewModel {

    let vm = HomeViewModel()
    vm.subscribedItemVMs = demoSubscribedItemVMs
    return vm
}

#endif
