//
//  ExploreSubscRowViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/12/15.
//

import Combine

final class ExploreSubscRowViewModel: ObservableObject {
    @Published var exploreSubscRepository: ExploreSubscRepository = FirestoreExploreSubscRepository()
    @Published var exploreSubscItemViewModels = [ExploreSubscItemViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        exploreSubscRepository.$items
            .map { items in
                items.map { item in
                    ExploreSubscItemViewModel(item: item)
                }
            }
            .assign(to: \.exploreSubscItemViewModels, on: self)
            .store(in: &cancellables)
    }
}

#if DEBUG

var demoExploreSubscRowVM: ExploreSubscRowViewModel {

    let vm = ExploreSubscRowViewModel()
    vm.exploreSubscItemViewModels = demoExploreSubscItemVM
    return vm
}

#endif
