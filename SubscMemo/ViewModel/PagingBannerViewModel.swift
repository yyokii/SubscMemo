//
//  PagingBannerViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/20.
//

import Combine
import Foundation

class PagingBannerViewModel: ObservableObject {
    @Published var contents: [BannerContentType] = []
    @Published var selectedIndex: Int

    private var cancellables = Set<AnyCancellable>()

    init() {
        contents = [.advertisement, .announcement(imageURL: "hogehoge//")]

        selectedIndex = 0

        Timer.publish(every: 2, on: .main, in: .default)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.selectedIndex < self.contents.count - 1 {
                    self.selectedIndex += 1
                } else {
                    self.selectedIndex = 0
                }
                print(self.selectedIndex)
            }
            .store(in: &cancellables)
    }

    func onChangeBanner(to index: Int) {
        if index != selectedIndex {
            selectedIndex = index
        }
    }
}
