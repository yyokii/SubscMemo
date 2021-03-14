//
//  UserProfileViewModel.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/15.
//

import Combine

final class UserProfileViewModel: ObservableObject {

    @Published var userProfileRepository: UserProfileRepository = FirestoreUserProfileRepository()

    @Published var name: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        userProfileRepository.$appUser
            .map { user in

                switch user?.status {
                case .uninitialized:
                    return ""
                case .authenticated:
                    return user?.name ?? ""
                case .authenticatedAnonymously:
                    return "ゲスト"
                case .none:
                    return ""
                }
            }
            .assign(to: \.name, on: self)
            .store(in: &cancellables)
    }
}

#if DEBUG

var demoUserProfileVM: UserProfileViewModel {

    let vm = UserProfileViewModel()
    vm.name = "ゲスト"
    return vm
}

#endif
