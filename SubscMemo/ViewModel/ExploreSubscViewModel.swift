//
//  ExploreSubscViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/23.
//

import Combine

import Resolver

final class ExploreSubscViewModel: ObservableObject {
    @Published var exploreSubscRepository: ExploreSubscRepository = Resolver.resolve()

    var exploreSubscItemVMs = [ExploreSubscItemViewModel]()
    @Published var displayVMs = [ExploreSubscItemViewModel]()

    var searchText = "" {
        didSet {
            self.searchService(text: searchText)
        }
    }

    private var cancellables = Set<AnyCancellable>()

    init() {
        exploreSubscRepository.$exploreItemJoinedDatas
            .map { items in
                items.map { ExploreSubscItemViewModel(item: ExploreSubscItemViewData.translate(from: $0)) }
            }
            .handleEvents(receiveOutput: { [weak self] vms in
                self?.displayVMs = vms
            })
            .assign(to: \.exploreSubscItemVMs, on: self)
            .store(in: &cancellables)

    }

    func searchService(text: String) {
        if text.isEmpty {
            displayVMs = exploreSubscItemVMs
        } else {
            let searchText = text.lowercased()
            let serchedItem = exploreSubscItemVMs
                .filter { vm in
                    vm.item.serviceName
                        .lowercased()
                        .contains(searchText)
                }
            displayVMs = serchedItem
        }
    }
}

#if DEBUG

var demoExploreSubscVM: ExploreSubscViewModel {

    let vm = ExploreSubscViewModel()
    vm.exploreSubscItemVMs = demoExploreSubscItemVMs
    return vm
}

#endif
