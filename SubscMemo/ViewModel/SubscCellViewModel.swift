//
//  SubscCellViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/11.
//

import SwiftUI
import Combine

final class SubscCellViewModel: ObservableObject, Identifiable {
    var subscRepository: SubscRepository = FirestoreSubscRepository()

    @Published var item: SubscItem

    var id: String = ""
    @Published var completionStateIconName = ""

    private var cancellables = Set<AnyCancellable>()

    static func newItem() -> SubscCellViewModel {
        SubscCellViewModel(item: SubscItem(title: "", completed: false))
    }

    init(item: SubscItem) {
        self.item = item

        $item
            .map { $0.completed ? "checkmark.circle.fill" : "circle" }
            .assign(to: \.completionStateIconName, on: self)
            .store(in: &cancellables)

        $item
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)

        $item
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { [weak self] item in
                self?.subscRepository.updateItem(item)
            }
            .store(in: &cancellables)
    }

}
