//
//  CreateCustomSubscItemViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/15.
//

import Combine

import FirebaseFirestore
import Resolver

final class CreateCustomSubscItemViewModel: ObservableObject {

    // Dialog Manager
    @Published var alertProvider = AlertProvider()

    // Repository
    @Injected var subscCategoryRepository: SubscCategoryRepository
    @Injected var subscribedServiceRepository: SubscribedServiceRepository

    @Published var categories: [SubscCategory] = []
    @Published var mainCategory: SubscCategory = SubscCategory.makeEmptyData()
    @Published var payAtDate: Date?
    @Published var subCategory: SubscCategory = SubscCategory.makeEmptyData()
    @Published var subscItem: SubscribedItem = SubscribedItem.makeEmptyData()

    private var cancellables = Set<AnyCancellable>()

    init() {
        alertProvider.objectWillChange
            .sink { [weak self] (_) in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)

        subscCategoryRepository.$categories
            .assign(to: \.categories, on: self)
            .store(in: &cancellables)
    }

    func addItem() {
        if let payAt = payAtDate {
            subscItem.payAt = Timestamp(date: payAt)
        }

        subscItem.categoryIDs[0] = mainCategory.categoryID
        subscItem.categoryIDs.insert(subCategory.categoryID, at: 1)

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

let demoCreateCustomSubscItemVM: CreateCustomSubscItemViewModel = {
    let vm = CreateCustomSubscItemViewModel()
    vm.categories = demoSubscCategories
    return vm
}()

#endif
