//
//  SelectSubscPlanViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/13.
//

import Combine

import Resolver

final class SelectSubscPlanViewModel: ObservableObject {
    @Published var selectedPlanID: String = ""
    private var cancellables = Set<AnyCancellable>()

    init() {}
}

#if DEBUG

var demoSelectSubscPlanVM: SelectSubscPlanViewModel {
    return SelectSubscPlanViewModel()
}

#endif
