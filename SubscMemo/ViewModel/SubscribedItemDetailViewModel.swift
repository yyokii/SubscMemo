//
//  SubscribedItemDetailViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/04.
//

import Combine

import Resolver

final class SubscribedItemDetailViewModel: ObservableObject {

    // Dialog Manager
    @Published var alertProvider = AlertProvider()

    // Repository
    @Published var subscribedServiceRepository: SubscribedServiceRepository = Resolver.resolve()

    @Published var plan: SubscPlanViewData = SubscPlanViewData.makeEmptyData()
    @Published var subscItem: SubscItemDetailViewData = SubscItemDetailViewData.makeEmptyData()
    var dataID: String!

    private var cancellables = Set<AnyCancellable>()

    init(dataID: String) {
        alertProvider.objectWillChange
            .sink { [weak self] (_) in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)

        self.dataID = dataID
    }

    func loadItemData() {
        loadItemData(dataID: dataID)
    }

    func loadItemData(dataID: String) {
        subscribedServiceRepository.loadJoinedData(with: dataID)
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

    func confirmDelete() {
        alertProvider.showConfirmAlert(
            title: "👋",
            message: "削除してもよろしいですか？",
            positiveAction: { [weak self] in
                self?.deleteItem()
            }
        )
    }

    func deleteItem() {
        subscribedServiceRepository.deleteItem(dataID: subscItem.id)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure:
                    self?.alertProvider.showErrorAlert(message: nil)
                case .finished:
                    break
                }
            }, receiveValue: {})
            .store(in: &cancellables)
    }
}

#if DEBUG

var demoSubscribedItemDetailVM: SubscribedItemDetailViewModel {
    let vm = SubscribedItemDetailViewModel(dataID: "")
    vm.subscItem = demoSubscItemDetailViewData
    return vm
}

#endif
