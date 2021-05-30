//
//  SearchSubscViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/04/07.
//

import Combine
import Resolver

// 使わないかも
final class SearchSubscViewModel: ObservableObject {

    @Published var exploreSubscRepository: ExploreSubscRepository = Resolver.resolve()

    @Published var categories: [SubscCategory] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        //        exploreSubscRepository.$categories
        //            .assign(to: \.categories, on: self)
        //            .store(in: &cancellables)
    }
}

#if DEBUG

var demoSearchSubscVM: SearchSubscViewModel {

    let vm = SearchSubscViewModel()
    vm.categories = demoSubscCategories
    return vm
}

#endif
