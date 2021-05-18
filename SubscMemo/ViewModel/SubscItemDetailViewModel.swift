//
//  SubscItemDetailViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/12.
//

import Combine

import Resolver

final class SubscItemDetailViewModel: ObservableObject {
    //    @Published var subscItem: SubscItem

    private var cancellables = Set<AnyCancellable>()

    init() {
        //        subscCategoryRepository.$categories
        //            .assign(to: \.categories, on: self)
        //            .store(in: &cancellables)
    }
}

#if DEBUG

//var demoSubscItemDetailVM: SubscItemDetailViewModel {
//
//    let vm = SubscItemDetailViewModel()
//    vm.categories = demoSubscCategories
//    return vm
//}

#endif
