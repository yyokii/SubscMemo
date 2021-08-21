//
//  AsyncImageColorLoaderTests.swift
//  SubscMemoTests
//
//  Created by Higashihara Yoki on 2021/08/11.
//

import SwiftUI
import XCTest
@testable import SubscMemo

class AsyncImageColorLoaderTests: XCTestCase {

    func testLoad_キャッシュされているものはキャッシュより取得される() {
        // given
        let url = URL(string: "demo")!
        let expectedColor: Color = .gray

        let loader = AsyncImageColorLoader(url: url)
        let stubCache = CacheImpl<URL, Color>()
        stubCache[url] = expectedColor
        AsyncImageColorLoader.cache = AnyCache(data: stubCache)

        // when
        loader.load()

        // then
        XCTAssertEqual(loader.averageColor, expectedColor)
    }
}
