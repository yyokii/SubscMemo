//
//  ExploreSubscItemDetailViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/12.
//

import Combine

import Resolver

final class ExploreSubscItemDetailViewModel: ObservableObject {
    @Published var alertProvider = AlertProvider()
    @Published var exploreSubscRepository: ExploreSubscRepository = Resolver.resolve()
    @Published var plans: [SubscPlanViewData] = [] // サブスクリプションサービスのプラン情報一覧
    var serviceID: String
    @Published var subscItem: ExploreSubscItemDetailViewData = ExploreSubscItemDetailViewData.makeEmptyData()

    private var cancellables = Set<AnyCancellable>()

    init(serviceID: String) {
        self.serviceID = serviceID

        alertProvider.objectWillChange
            .sink { [weak self] (_) in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }

    ///　サービス情報とプラン情報を取得
    func loadData() {
        loadItemData(serviceID: serviceID)
        loadPlanData(serviceID: serviceID)
    }

    func loadItemData(serviceID: String) {
        exploreSubscRepository.loadJoinedData(with: serviceID)
            .sink(receiveCompletion: { [weak self] completion in

                switch completion {
                case .failure:
                    self?.alertProvider.showErrorAlert(message: nil)
                case .finished:
                    break
                }

            }, receiveValue: { [weak self] item in
                self?.subscItem = ExploreSubscItemDetailViewData.translate(from: item)
            })
            .store(in: &cancellables)
    }

    func loadPlanData(serviceID: String) {
        exploreSubscRepository.loadPlans(of: serviceID)
            .sink(receiveCompletion: { [weak self] completion in

                switch completion {
                case .failure:
                    self?.alertProvider.showErrorAlert(message: nil)
                case .finished:
                    break
                }

            }, receiveValue: { [weak self] plans in
                self?.plans = plans.map {
                    SubscPlanViewData.translate(from: $0)
                }
            })
            .store(in: &cancellables)
    }
}

#if DEBUG

var demoExploreSubscItemDetailVM: ExploreSubscItemDetailViewModel {
    let vm = ExploreSubscItemDetailViewModel(serviceID: "")
    vm.plans = demoSubscPlanViewDatas
    vm.subscItem = demoExploreSubscItemDetailViewData
    return vm
}

#endif
