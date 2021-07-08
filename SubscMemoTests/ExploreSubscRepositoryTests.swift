//
//  ExploreSubscRepositoryTests.swift
//  SubscMemoTests
//
//  Created by Higashihara Yoki on 2021/06/10.
//

import Combine
import XCTest
@testable import SubscMemo

class ExploreSubscRepositoryTests: XCTestCase {

    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        cancellables = []
    }

    func testLoadDataWithServiceID() {
        // given
        let repository = FirestoreExploreSubscRepository()
        let cachedItems = [
            ExploreSubscItem(
                categoryIDs: ["demo-id"],
                createdTime: nil,
                description: "demo-description",
                iconImageURL: "https://via.placeholder.com/150",
                id: "demo-id-01",
                name: "demo-name01",
                serviceID: "1",
                serviceURL: "https://www.google.com/?hl=ja"
            ),
            ExploreSubscItem(
                categoryIDs: ["demo-id"],
                createdTime: nil,
                description: "demo-description",
                iconImageURL: "https://via.placeholder.com/150",
                id: "demo-id-02",
                name: "demo-name01",
                serviceID: "2",
                serviceURL: "https://www.google.com/?hl=ja"
            )
        ]
        repository.exploreSubscItems = cachedItems

        // when
        let result = repository.loadDataFromCache(with: ["1", "2"])

        // then
        XCTAssertEqual(result[0].serviceID, cachedItems[0].serviceID)
        XCTAssertEqual(result[1].serviceID, cachedItems[1].serviceID)
    }
}
