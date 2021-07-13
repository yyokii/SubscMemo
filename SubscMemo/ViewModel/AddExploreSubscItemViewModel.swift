//
//  AddExploreSubscItemViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/08.
//

import Combine

import FirebaseFirestore
import Resolver

final class AddExploreSubscItemViewModel: ObservableObject {

    // Dialog Manager
    @Published var alertProvider = AlertProvider()

    // Repository
    @Injected var exploreSubscRepository: ExploreSubscRepository
    @Injected var subscribedServiceRepository: SubscribedServiceRepository

    @Published var payAtDate: Date?
    @Published var planDatas: [SubscPlanViewData] = []
    let serviceID: String
    @Published var selectSubscPlanViewModel = SelectSubscPlanViewModel()
    @Published var subscItem: SubscribedItem = SubscribedItem.makeEmptyData(isUserOriginal: false)

    private var cancellables = Set<AnyCancellable>()

    init(serviceID: String) {
        self.serviceID = serviceID

        alertProvider.objectWillChange
            .sink { [weak self] (_) in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)

        loadData(of: self.serviceID)
        loadPlanData(of: self.serviceID)

        selectSubscPlanViewModel.$selectedPlanID
            .sink(receiveValue: { [weak self] planID in
                if !serviceID.isEmpty,
                   let selectedPlan = self?.planDatas.first(where: { $0.planID == planID }) {
                    self?.subscItem.planID = selectedPlan.planID
                    self?.subscItem.planName = selectedPlan.planName
                    self?.subscItem.price = selectedPlan.price
                    self?.subscItem.cycle = selectedPlan.cycle
                }
            })
            .store(in: &cancellables)
    }

    func loadData(of serviceID: String) {
        exploreSubscRepository.loadData(with: [serviceID])
            .first()
            .sink(receiveCompletion: { [weak self] completion in

                switch completion {
                case .failure:
                    self?.alertProvider.showErrorAlert(message: nil)
                case .finished:
                    break
                }

            }, receiveValue: { [weak self] items in
                let targetItem = items[0]
                self?.subscItem = SubscribedItem.translate(from: targetItem)
            })
            .store(in: &cancellables)
    }

    func loadPlanData(of serviceID: String) {
        exploreSubscRepository.loadPlans(of: serviceID)
            .sink(receiveCompletion: { [weak self] completion in

                switch completion {
                case .failure:
                    self?.alertProvider.showErrorAlert(message: nil)
                case .finished:
                    break
                }

            }, receiveValue: { [weak self] plans in
                self?.planDatas = plans.map {
                    SubscPlanViewData.translate(from: $0)
                }
            })
            .store(in: &cancellables)
    }

    func addItem() {
        if let payAt = payAtDate {
            subscItem.payAt = Timestamp(date: payAt)
        }

        subscribedServiceRepository.addSubscribedItem(data: subscItem)
            .sink(receiveCompletion: { [weak self] completion in

                switch completion {
                case .failure:
                    self?.alertProvider.showErrorAlert(message: nil)
                case .finished:
                    break
                }

            }, receiveValue: { })
            .store(in: &cancellables)
    }
}

#if DEBUG

let demoAddExploreSubscItemVM: AddExploreSubscItemViewModel = {
    let vm = AddExploreSubscItemViewModel(serviceID: "")
    vm.payAtDate = Date()
    vm.subscItem = demoSubscItems[0]
    return vm
}()

#endif
