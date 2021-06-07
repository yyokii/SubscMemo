//
//  ExploreSubscItemDetailViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/12.
//

import Combine

import Resolver

final class ExploreSubscItemDetailViewModel: ObservableObject {

    @Published var exploreSubscRepository: ExploreSubscRepository = Resolver.resolve()
    @Published var plans: [SubscPlanViewData] = [] // サブスクリプションサービスのプラン情報一覧
    var serviceID: String
    @Published var subscItem: ExploreSubscItemDetailViewData = ExploreSubscItemDetailViewData.makeEmptyData()

    private var cancellables = Set<AnyCancellable>()

    init(serviceID: String) {
        self.serviceID = serviceID
        loadItemData(serviceID: self.serviceID)
    }

    func loadItemData(serviceID: String) {
        exploreSubscRepository.loadJoinedData(with: serviceID)
            .sink(receiveCompletion: { completion in

                switch completion {
                case .failure(let error):
                    #warning("アラートを出す")
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
            .sink(receiveCompletion: { completion in

                switch completion {
                case .failure(let error):
                    #warning("アラートを出す")
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
