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

    // Manage View Presentation
    var dismissViewPublisher = PassthroughSubject<Bool, Never>()
    private var shouldDismissView = false {
        didSet {
            dismissViewPublisher.send(shouldDismissView)
        }
    }

    @Published var categories: [SubscCategory] = []
    @Published var isRequestedReview = false
    @Published var mainCategory: SubscCategory = SubscCategory.makeEmptyData()
    @Published var subCategory: SubscCategory = SubscCategory.makeEmptyData()
    @Published var subscItem: SubscribedItem = SubscribedItem.makeEmptyData(isUserOriginal: true)
    @Published var validationVM = ValidationStateViewModel()

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
        let validation = validate(item: subscItem)

        guard validation.result else {
            validationVM.state = .invalid(validation.message)
            return
        }

        subscItem.setMainCategoryID(categoryID: mainCategory.categoryID)
        subscItem.setSubCategoryID(categoryID: subCategory.categoryID)

        subscribedServiceRepository.addSubscribedItem(data: subscItem)
            .sink(receiveCompletion: { [weak self] completion in

                switch completion {
                case .failure:
                    self?.alertProvider.showErrorAlert(message: nil)
                case .finished:
                    self?.alertProvider.showSuccessAlert(
                        title: "😊",
                        message: "追加しました！",
                        action: { [weak self] in
                            self?.shouldDismissView = true

                            let reviewReqManager = ReviewRequestManagerImpl.standard
                            reviewReqManager.incrementProcessCount()

                            if reviewReqManager.canRequestReview {
                                reviewReqManager.requestReview()
                            }
                        }
                    )
                }

            }, receiveValue: { })
            .store(in: &cancellables)
    }

    func validate(item: SubscribedItem) -> (result: Bool, message: String) {
        var message = ""

        if item.name.isEmpty {
            message += "「サービス名」を入力してくださいさい\n"
        }

        if item.cycle.isEmpty {
            message += "「支払いサイクル」を入力してくださいさい\n"
        }

        if !mainCategory.isValidData() {
            message += "「メインカテゴリー」を入力してください\n"
        }

        return (message.isEmpty, message)
    }
}

#if DEBUG

let demoCreateCustomSubscItemVM: CreateCustomSubscItemViewModel = {
    let vm = CreateCustomSubscItemViewModel()
    vm.categories = demoSubscCategories
    return vm
}()

#endif
