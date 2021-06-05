//
//  SubscribedItemDetailViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/04.
//

import Combine

import Resolver

final class SubscribedItemDetailViewModel: ObservableObject {
    @Published var plan: SubscPlanViewData = SubscPlanViewData.makeEmptyData()
    @Published var subscItem: SubscItemDetailViewData = SubscItemDetailViewData.makeEmptyData()
    var serviceID: String!
    @Published var subscribedServiceRepository: SubscribedServiceRepository = Resolver.resolve()

    enum PresentationType {
        case exploredServiceDetail
        case subscribedServiceDetail
    }

    private var cancellables = Set<AnyCancellable>()

    init(serviceID: String) {
        self.serviceID = serviceID
        loadItemData(serviceID: self.serviceID)
    }

    func loadItemData(serviceID: String) {
        subscribedServiceRepository.loadData(with: serviceID)
            .sink(receiveCompletion: { completion in

                switch completion {
                case .failure(let error):
                    #warning("アラートを出す")
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
