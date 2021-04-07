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

    @Published var item: SubscItem!

    private var cancellables = Set<AnyCancellable>()

    init(item: SubscItem) {
        self.item = item
    }

    static func newItem() -> EditSubscViewModel {
        EditSubscViewModel(item: SubscItem.makeNewItem())
    }

    func addItem(item: SubscItem) {
        subscRepository.addItem(item)
    }

    func deleteItem(item: SubscItem) {
        subscRepository.deleteItem(item)
    }
}
