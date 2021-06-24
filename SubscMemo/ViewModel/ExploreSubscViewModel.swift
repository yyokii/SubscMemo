//
//  ExploreSubscViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/23.
//

import Combine

import Resolver

final class ExploreSubscViewModel: ObservableObject {
    @Published var exploreSubscRepository: ExploreSubscRepository = Resolver.resolve()
    @Published var exploreSubscItemVMs = [ExploreSubscItemViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        exploreSubscRepository.$exploreItemJoinedDatas
            .map { items in
                items.map { ExploreSubscItemViewModel(item: ExploreSubscItemViewData.translate(from: $0)) }
            }
            .assign(to: \.exploreSubscItemVMs, on: self)
            .store(in: &cancellables)
    }
}

#if DEBUG

var demoExploreSubscVM: ExploreSubscViewModel {

    let vm = ExploreSubscViewModel()
    vm.exploreSubscItemVMs = demoExploreSubscItemVMs
    return vm
}

#endif
