//
//  XCTestCase+AwaitCompletion.swift
//  SubscMemoTests
//
//  Created by Higashihara Yoki on 2021/06/10.
//

import Combine
import XCTest

extension XCTestCase {
    func awaitCompletion<P: Publisher>(for publisher: P) -> Result<[P.Output], P.Failure> {
        let finishedExpectation = expectation(description: "completion expectation")
        var output = [P.Output]()
        var result: Result<[P.Output], P.Failure>!
        _ = publisher
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    result = .failure(error)
                } else {
                    result = .success(output)
                }
                finishedExpectation.fulfill()
            },
            receiveValue: { value in
                output.append(value)
            })
        waitForExpectations(timeout: 1.0, handler: nil)
        return result
    }
}
