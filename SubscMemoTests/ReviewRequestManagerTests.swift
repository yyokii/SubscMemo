//
//  ReviewRequestManagerTests.swift
//  SubscMemoTests
//
//  Created by Higashihara Yoki on 2021/08/25.
//

import XCTest
@testable import SubscMemo

class ReviewRequestManagerTests: XCTestCase {
    func test_規定のプロセス数（2回）を超えるとレビューリクエストが可能になる() {
        let manager = ReviewRequestManagerImpl.init(userDefaults: MockUserDefaults(),
                                                    currentAppVersion: "1.0.0",
                                                    thresholdCountForReviewRequest: 2,
                                                    waitTimeForReviewRequest: 0)

        XCTContext.runActivity(named: "プロセス数が0→1") { _ in
            manager.incrementProcessCount()
            let result = manager.canRequestReview
            let expectation = false

            XCTAssertEqual(result, expectation)
        }

        XCTContext.runActivity(named: "プロセス数が1→2") { _ in
            manager.incrementProcessCount()
            let result = manager.canRequestReview
            let expectation = true

            XCTAssertEqual(result, expectation)
        }
    }

    // swiftlint:disable function_body_length
    func test_規定のプロセス数（2回）を超え且つレビューリクエスト済みのバージョンでなければレビューリクエストが可能になる() {

        let thresholdCountForReviewRequest = 2
        XCTContext.runActivity(named: "一度もレビューをしたことがない") { _ in
            let manager = ReviewRequestManagerImpl.init(userDefaults: MockUserDefaults(),
                                                        currentAppVersion: "",
                                                        thresholdCountForReviewRequest: thresholdCountForReviewRequest,
                                                        waitTimeForReviewRequest: 0)
            manager.processCount = thresholdCountForReviewRequest
            let result = manager.canRequestReview
            let expectation = true

            XCTAssertEqual(result, expectation)
        }

        XCTContext.runActivity(named: "バージョン1.0.0でレビュー済み") { _ in
            let dataStore = MockUserDefaults()
            dataStore.set("1.0.0", forKey: .lastVersionPromptedForReview)

            XCTContext.runActivity(named: "レビュー要求がバージョン1.0.0") { _ in
                let manager = ReviewRequestManagerImpl.init(userDefaults: dataStore,
                                                            currentAppVersion: "1.0.0",
                                                            thresholdCountForReviewRequest: thresholdCountForReviewRequest,
                                                            waitTimeForReviewRequest: 0)
                manager.processCount = thresholdCountForReviewRequest
                let result = manager.canRequestReview
                let expectation = false

                XCTAssertEqual(result, expectation)
            }

            XCTContext.runActivity(named: "レビュー要求がバージョン1.1.0") { _ in
                let manager = ReviewRequestManagerImpl.init(userDefaults: dataStore,
                                                            currentAppVersion: "1.1.0",
                                                            thresholdCountForReviewRequest: thresholdCountForReviewRequest,
                                                            waitTimeForReviewRequest: 0)
                manager.processCount = thresholdCountForReviewRequest
                let result = manager.canRequestReview
                let expectation = true

                XCTAssertEqual(result, expectation)
            }

            XCTContext.runActivity(named: "レビュー要求がバージョン2.0.0") { _ in
                let manager = ReviewRequestManagerImpl.init(userDefaults: dataStore,
                                                            currentAppVersion: "2.0.0",
                                                            thresholdCountForReviewRequest: thresholdCountForReviewRequest,
                                                            waitTimeForReviewRequest: 0)
                manager.processCount = thresholdCountForReviewRequest
                let result = manager.canRequestReview
                let expectation = true

                XCTAssertEqual(result, expectation)
            }

            XCTContext.runActivity(named: "レビュー要求がバージョン0.0.1") { _ in
                let manager = ReviewRequestManagerImpl.init(userDefaults: dataStore,
                                                            currentAppVersion: "0.0.1",
                                                            thresholdCountForReviewRequest: thresholdCountForReviewRequest,
                                                            waitTimeForReviewRequest: 0)
                manager.processCount = thresholdCountForReviewRequest
                let result = manager.canRequestReview
                let expectation = true

                XCTAssertEqual(result, expectation)
            }
        }
    }
}
