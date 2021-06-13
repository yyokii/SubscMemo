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
    @Published var exploreSubscRepository: ExploreSubscRepository = Resolver.resolve()
    @Published var payAtDate: Date?
    @Published var planDatas: [SubscPlanViewData] = []
    let serviceID: String
    @Published var selectSubscPlanViewModel = SelectSubscPlanViewModel()
    @Published var subscItem: SubscribedItem = SubscribedItem.makeEmptyData()
    @Published var userProfileRepository: UserProfileRepository = Resolver.resolve()

    private var cancellables = Set<AnyCancellable>()

    init(serviceID: String) {
        self.serviceID = serviceID

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
            .sink(receiveCompletion: { completion in

                switch completion {
                case .failure(let error):
                    #warning("アラートを出す")
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
            .sink(receiveCompletion: { completion in

                switch completion {
                case .failure(let error):
                    #warning("アラートを出す")
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

        userProfileRepository.addSubscribedService(data: subscItem)
            .sink(receiveCompletion: { completion in

                switch completion {
                case .failure(let error):
                    #warning("アラートを出す")
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
