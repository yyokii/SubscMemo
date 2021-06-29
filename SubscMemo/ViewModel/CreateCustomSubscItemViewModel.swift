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
    @Published var alertProvider = AlertProvider()
    @Published var categories: [SubscCategory] = []
    @Published var mainCategory: SubscCategory = SubscCategory.makeEmptyData()
    @Published var payAtDate: Date?
    @Published var subCategory: SubscCategory = SubscCategory.makeEmptyData()
    @Injected var subscCategoryRepository: SubscCategoryRepository
    @Published var subscItem: SubscribedItem = SubscribedItem.makeEmptyData()
    @Published var userProfileRepository: UserProfileRepository = Resolver.resolve()

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

        subscItem.mainCategoryID = mainCategory.categoryID
        subscItem.subCategoryID = subCategory.categoryID

        userProfileRepository.addSubscribedService(data: subscItem)
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
