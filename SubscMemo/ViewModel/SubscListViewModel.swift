//
//  SubscListViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/11.
//

import SwiftUI
import Combine

final class SubscListViewModel: ObservableObject {
    @Published var subscRepository: SubscRepository = FirestoreSubscRepository()
    @Published var subscCellViewModels = [SubscCellViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        subscRepository.$items
            .map { items in
                items.map { item in
                    SubscCellViewModel(item: item)
                }
            }
            .assign(to: \.subscCellViewModels, on: self)
            .store(in: &cancellables)
    }

    func addItem(item: SubscItem) {
        subscRepository.addItem(item)
    }
}
