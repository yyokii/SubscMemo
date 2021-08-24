//
//  AnnouncementBannerRepository.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/20.
//

import Combine

import FirebaseFirestore
import FirebaseFirestoreSwift

class BaseAnnouncementBannerRepository {
    @Published var banners: [Banner] = []
}

protocol AnnouncementBannerRepository: BaseAnnouncementBannerRepository {
    func loadBanner()
}

final class FirestoreAnnouncementBannerRepository: BaseAnnouncementBannerRepository, AnnouncementBannerRepository, ObservableObject {

    private var cancellables = Set<AnyCancellable>()
    private var db: Firestore = Firestore.firestore()

    override init() {
        super.init()

        loadBanner()
    }

    func loadBanner() {
        db
            .collection(FirestorePathComponent.announcement.rawValue)
            .document(FirestorePathComponent.version.rawValue)
            .collection(FirestorePathComponent.banners.rawValue)
            .getDocuments(as: Banner.self)
            .map({ banners in
                banners.filter { $0.isActive() }
            })
            .replaceError(with: banners)
            .assign(to: \.banners, on: self)
            .store(in: &cancellables)
    }
}
