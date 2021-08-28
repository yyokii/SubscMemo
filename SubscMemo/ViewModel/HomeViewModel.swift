//
//  HomeViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/11.
//

import Combine
import WidgetKit

import Resolver

final class HomeViewModel: ObservableObject {
    // Data Store
    let dataStore: KeyValueStore

    // Repository
    @Injected var subscribedServiceRepository: SubscribedServiceRepository

    @Published var subscribedItemVMs = [SubscribedItemViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init(userDataStore: KeyValueStore = UserDefaults.init(suiteName: UserDefaultSuiteName.mysubscmemo.rawValue)!) {
        dataStore = userDataStore

        subscribedServiceRepository.$joinedDatas
            .map { items in
                items.map { SubscribedItemViewModel(item: $0) }
            }
            .handleEvents(receiveOutput: { [weak self] data in
                self?.dataStore.set(data.count, forKey: .cachedServiceCount)
                WidgetCenter.shared.reloadAllTimelines()
            })
            .assign(to: \.subscribedItemVMs, on: self)
            .store(in: &cancellables)
    }
}

#if DEBUG

var demoHomeVM: HomeViewModel {

    let vm = HomeViewModel()
    vm.subscribedItemVMs = demoSubscribedItemVMs
    return vm
}

#endif
