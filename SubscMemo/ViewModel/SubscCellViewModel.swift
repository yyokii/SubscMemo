//
//  SubscCellViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/11.
//

import Combine

import Resolver

final class SubscCellViewModel: ObservableObject, Identifiable {

    var subscRepository: SubscRepository = Resolver.resolve()

    @Published var item: SubscribedItem

    private var cancellables = Set<AnyCancellable>()

    //    static func newItem() -> SubscCellViewModel {
    //        SubscCellViewModel(item: SubscribedItem(title: "", completed: false))
    //    }

    init(item: SubscribedItem) {
        self.item = item

        $item
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { [weak self] item in
                self?.subscRepository.updateItem(item)
            }
            .store(in: &cancellables)
    }
}

#if DEBUG

let demoSubscCellVM = [
    SubscCellViewModel(item: demoSubscItems[0]),
    SubscCellViewModel(item: demoSubscItems[1])
]

#endif
