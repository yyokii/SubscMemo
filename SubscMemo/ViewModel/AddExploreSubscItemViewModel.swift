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

    @Published var planDatas: [SubscPlanViewData] = []
    @Published var selectSubscPlanViewModel = SelectSubscPlanViewModel()
    @Published var subscItem: SubscribedItem = .makeEmptyData(isUserOriginal: false)
    @Published var validationVM = ValidationStateViewModel()

    private var cancellables = Set<AnyCancellable>()

    init(exploreItemJoinedData: ExploreItemJoinedData, plans: [SubscPlanViewData]) {
        alertProvider.objectWillChange
            .sink { [weak self] (_) in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)

        planDatas = plans
        subscItem = SubscribedItem.translate(from: exploreItemJoinedData)

        selectSubscPlanViewModel.$selectedPlanID
            .sink(receiveValue: { [weak self] planID in
                guard !planID.isEmpty else {
                    self?.subscItem.planID = nil
                    self?.subscItem.planName = nil
                    self?.subscItem.price = 0
                    self?.subscItem.cycle = ""
                    return
                }

                if let selectedPlan = self?.planDatas.first(where: { $0.planID == planID }),
                   let paymentCycle = selectedPlan.cycle {
                    self?.subscItem.planID = selectedPlan.planID
                    self?.subscItem.planName = selectedPlan.planName
                    self?.subscItem.price = selectedPlan.price
                    self?.subscItem.cycle = paymentCycle.rawValue
                }
            })
            .store(in: &cancellables)
    }

    func addItem() {
        let validation = validate(item: subscItem)

        guard validation.result else {
            validationVM.state = .invalid(validation.message)
            return
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

    func validate(item: SubscribedItem) -> (result: Bool, message: String) {
        var message = ""

        if item.cycle.isEmpty {
            message += "「支払いサイクル」を入力してくださいさい\n"
        }

        return (message.isEmpty, message)
    }
}

#if DEBUG

var demoAddExploreSubscItemVM: AddExploreSubscItemViewModel {
    let vm = AddExploreSubscItemViewModel(
        exploreItemJoinedData: demoExploreItemJoinedDatas[0],
        plans: demoSubscPlanViewDatas
    )
    return vm
}

#endif
