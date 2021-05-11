//
//  SubscCategoryRowViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/11.
//

import Combine

import Resolver

final class SubscCategoryRowViewModel: ObservableObject {
    @Published var subscCategoryRepository: SubscCategoryRepository = Resolver.resolve()
    @Published var categories = [SubscCategory]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        subscCategoryRepository.$categories
            .assign(to: \.categories, on: self)
            .store(in: &cancellables)
    }
}

#if DEBUG

var demoSubscCategoryRowVM: SubscCategoryRowViewModel {

    let vm = SubscCategoryRowViewModel()
    vm.categories = demoSubscCategories
    return vm
}

#endif
