//
//  ExploreSubscItemViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/12/15.
//

import Combine

final class ExploreSubscItemViewModel: ObservableObject, Identifiable {

    @Published var item: ExploreSubscItemViewData

    private var cancellables = Set<AnyCancellable>()

    init(item: ExploreSubscItemViewData) {
        self.item = item
    }
}

#if DEBUG

let demoExploreSubscItemVMs = [
    ExploreSubscItemViewModel(item: ExploreSubscItemViewData.translate(from: demoExploreItemJoinedDatas[0])),
    ExploreSubscItemViewModel(item: ExploreSubscItemViewData.translate(from: demoExploreItemJoinedDatas[1]))
]

#endif
