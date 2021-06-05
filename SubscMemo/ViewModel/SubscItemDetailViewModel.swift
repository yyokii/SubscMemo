//
//  SubscItemDetailViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/12.
//

import Combine

import Resolver

#warning("SubscribedItemDetailViewModelを作って詳細は分けたので修正する")
final class SubscItemDetailViewModel: ObservableObject {

    //    @Published var exploreSubscRepository: ExploreSubscRepository = Resolver.resolve()
    //    @Published var plans: [SubscPlanViewData] = [] // サブスクリプションサービスのプラン情報一覧
    //    let presentationType: PresentationType
    //    let subscItem: SubscItemDetailViewData

    enum PresentationType {
        case exploredServiceDetail
        case subscribedServiceDetail
    }

    private var cancellables = Set<AnyCancellable>()

    //    init(with data: ExploreSubscItem, presentationType: PresentationType = .exploredServiceDetail) {
    //        subscItem = SubscItemDetailViewData.translate(from: data)
    //        self.presentationType = presentationType
    //    }

    //    func fetchPlanData(of serviceID: String) {
    //        exploreSubscRepository.loadPlans(of: serviceID)
    //            .sink(receiveCompletion: { completion in
    //
    //                switch completion {
    //                case .failure(let error):
    //                    #warning("アラートを出す")
    //                case .finished:
    //                    break
    //                }
    //
    //            }, receiveValue: { plans in
    //                self.plans = plans.map {
    //                    SubscPlanViewData.translate(from: $0)
    //                }
    //            })
    //            .store(in: &cancellables)
    //    }
}

#if DEBUG

//var demoSubscItemDetailVM: SubscItemDetailViewModel {
//
//    let vm = SubscItemDetailViewModel()
//    vm.categories = demoSubscCategories
//    return vm
//}

#endif
