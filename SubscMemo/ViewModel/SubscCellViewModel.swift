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

    @Published var item: SubscItem

    private var cancellables = Set<AnyCancellable>()

    //    static func newItem() -> SubscCellViewModel {
    //        SubscCellViewModel(item: SubscItem(title: "", completed: false))
    //    }

    init(item: SubscItem) {
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
    SubscCellViewModel(item: testDataTasks[0]),
    SubscCellViewModel(item: testDataTasks[1])
]

#endif
