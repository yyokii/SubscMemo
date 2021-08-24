//
//  PagingBannerViewModel.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/20.
//

import Combine
import Foundation

import Resolver

class PagingBannerViewModel: ObservableObject {

    // Repository
    @Injected var announcementBannerRepository: AnnouncementBannerRepository

    @Published var contents: [BannerContentType] = []
    @Published var selectedIndex: Int

    private var cancellables = Set<AnyCancellable>()

    init() {
        contents = [.advertisement]
        selectedIndex = 0

        announcementBannerRepository.$banners
            .map { banners in
                banners
                    .compactMap {
                        URL.init(string: $0.imageURL)
                    }
                    .map {
                        BannerContentType.announcement(imageURL: $0)
                    }
            }
            .sink(receiveValue: { contents  in
                self.contents.append(contentsOf: contents)
            })
            .store(in: &cancellables)

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
            }
            .store(in: &cancellables)
    }

    func onChangeBanner(to index: Int) {
        if index != selectedIndex {
            selectedIndex = index
        }
    }
}
