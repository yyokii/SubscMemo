//
//  ExploreSubscItemViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/12/15.
//

import Combine

final class ExploreSubscItemViewModel: ObservableObject, Identifiable {

    @Published var item: ExploreSubscItem

    private var cancellables = Set<AnyCancellable>()

    init(item: ExploreSubscItem) {
        self.item = item
    }
}

#if DEBUG

let demoExploreSubscItemVM = [
    ExploreSubscItemViewModel(item: demoExploreSubscItems[0]),
    ExploreSubscItemViewModel(item: demoExploreSubscItems[1])
]

#endif
