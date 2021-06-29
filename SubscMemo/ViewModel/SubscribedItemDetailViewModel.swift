//
//  SubscribedItemDetailViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/04.
//

import Combine

import Resolver

final class SubscribedItemDetailViewModel: ObservableObject {
    @Published var alertProvider = AlertProvider()
    @Published var plan: SubscPlanViewData = SubscPlanViewData.makeEmptyData()
    @Published var subscItem: SubscItemDetailViewData = SubscItemDetailViewData.makeEmptyData()
    var serviceID: String!
    @Published var subscribedServiceRepository: SubscribedServiceRepository = Resolver.resolve()

    private var cancellables = Set<AnyCancellable>()

    init(serviceID: String) {
        alertProvider.objectWillChange
            .sink { [weak self] (_) in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)

        self.serviceID = serviceID
    }

    func loadItemData() {
        loadItemData(serviceID: serviceID)
    }

    func loadItemData(serviceID: String) {
        subscribedServiceRepository.loadData(with: serviceID)
            .sink(receiveCompletion: { [weak self] completion in

                switch completion {
                case .failure:
                    self?.alertProvider.showErrorAlert(message: nil)
                case .finished:
                    break
                }

            }, receiveValue: { [weak self] item in
                self?.subscItem = SubscItemDetailViewData.translate(from: item)
                self?.plan = SubscPlanViewData.translate(from: item)
            })
            .store(in: &cancellables)
    }
}

#if DEBUG

var demoSubscribedItemDetailVM: SubscribedItemDetailViewModel {
    let vm = SubscribedItemDetailViewModel(serviceID: "")
    vm.subscItem = demoSubscItemDetailViewData
    return vm
}

#endif
