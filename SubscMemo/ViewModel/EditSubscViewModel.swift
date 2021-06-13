//
//  EditSubscViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/20.
//

import Combine

import Resolver

final class EditSubscViewModel: ObservableObject {

    @Published var subscRepository: SubscRepository = Resolver.resolve()

    @Published var item: SubscribedItem!

    private var cancellables = Set<AnyCancellable>()

    init(item: SubscribedItem) {
        self.item = item
    }

    static func newItem() -> EditSubscViewModel {
        EditSubscViewModel(item: SubscribedItem.makeEmptyData())
    }

    func addItem(item: SubscribedItem) {
        subscRepository.addItem(item)
    }

    func deleteItem(item: SubscribedItem) {
        subscRepository.deleteItem(item)
    }
}
