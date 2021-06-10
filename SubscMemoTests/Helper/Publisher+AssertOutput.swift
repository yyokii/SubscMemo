//
//  Publisher+AssertOutput.swift
//  SubscMemoTests
//
//  Created by Higashihara Yoki on 2021/06/10.
//

import XCTest
import Combine

extension Publisher where Output: Equatable {
    func assertOutput(matches: [Output], expectation: XCTestExpectation) -> AnyCancellable {
        var expectedValues = matches
        return self
            .sink(receiveCompletion: { _ in

            },
            receiveValue: { value in
                guard let expectedValue = expectedValues.first else {
                    XCTFail("The publisher emitted more values than expected.")
                    return

                }
                guard expectedValue == value else {
                    XCTFail("Expected received value \(value) to match first 􏰀→ expected value \(expectedValue)")
                    return
                }
                expectedValues = Array(expectedValues.dropFirst())
                if expectedValues.isEmpty {
                    expectation.fulfill()
                }
            })
    }
}
