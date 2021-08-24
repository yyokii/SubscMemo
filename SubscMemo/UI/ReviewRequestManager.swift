//
//  ReviewRequestManager.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/24.
//

import StoreKit

protocol ReviewRequestManager {
    var userDefault: KeyValueStore { get }
    var canRequestReview: Bool { get }

    func requestReview(in windowScene: UIWindowScene)
}

/*
 Requesting App Store Reviews:  https://developer.apple.com/documentation/storekit/requesting_app_store_reviews
 Human Interface Guideline: https://developer.apple.com/design/human-interface-guidelines/ios/system-capabilities/ratings-and-reviews/
 */
class ReviewRequestManagerImpl: ReviewRequestManager {

    static let standard = ReviewRequestManagerImpl(currentAppVersion: AppVersion.current.productVersion)

    // Data resource
    var userDefault: KeyValueStore = UserDefaults.standard

    // Properties to check if we can request a review
    var lastVersionPromptedForReview: String? {
        get {
            return userDefault.string(forKey: .lastVersionPromptedForReview)
        }

        set {
            userDefault.set(newValue ?? "", forKey: .lastVersionPromptedForReview)
        }
    }
    var processCount: Int {
        get {
            return userDefault.int(forKey: .processAddSubscribedItemCount)
        }

        set {
            userDefault.set(newValue, forKey: .processAddSubscribedItemCount)
        }
    }
    var currentAppVersion: String
    var thresholdCountForReviewRequest: Int
    var waitTimeForReviewRequest: Double
    var canRequestReview: Bool {
        return (processCount >= thresholdCountForReviewRequest) && (currentAppVersion != lastVersionPromptedForReview)
    }

    var requestReviewWorkItem: DispatchWorkItem?

    init(userDefaults: KeyValueStore = UserDefaults.standard,
         currentAppVersion: String,
         thresholdCountForReviewRequest: Int = 2,
         waitTimeForReviewRequest: Double = 2.0) {

        self.userDefault = userDefaults
        self.currentAppVersion = currentAppVersion
        self.thresholdCountForReviewRequest = thresholdCountForReviewRequest
        self.waitTimeForReviewRequest = waitTimeForReviewRequest
    }

    func incrementProcessCount() {
        processCount += 1
    }

    func requestReview(in windowScene: UIWindowScene) {
        requestReviewWorkItem?.cancel()

        requestReviewWorkItem = DispatchWorkItem(block: { [weak self] in
            SKStoreReviewController.requestReview(in: windowScene)
            self?.lastVersionPromptedForReview = self?.currentAppVersion
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + waitTimeForReviewRequest, execute: requestReviewWorkItem!)
    }
}
