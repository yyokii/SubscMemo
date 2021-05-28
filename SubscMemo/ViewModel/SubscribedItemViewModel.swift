//
//  SubscribedItemViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/28.
//

import Combine

import Resolver

final class SubscribedItemViewModel: ObservableObject, Identifiable {

    @Published var item: SubscribedItemViewData

    private var cancellables = Set<AnyCancellable>()

    init(item: SubscribedItemJoinedData) {
        self.item = SubscribedItemViewData(data: item)
    }
}

#if DEBUG

let demoSubscribedItemVMs = [
    SubscribedItemViewModel(item: demoSubscItemJoinedDatas[0]),
    SubscribedItemViewModel(item: demoSubscItemJoinedDatas[1])
]

#endif
