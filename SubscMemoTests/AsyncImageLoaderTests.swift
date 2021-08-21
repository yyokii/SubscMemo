//
//  AsyncImageLoaderTests.swift
//  SubscMemoTests
//
//  Created by Higashihara Yoki on 2021/08/21.
//

import SwiftUI
import XCTest
@testable import SubscMemo

class AsyncImageLoaderTests: XCTestCase {

    func testLoad_キャッシュされているものはキャッシュより取得される() {
        // given
        let url = URL(string: "demo")!
        let expectedImage: Image = .init(systemName: "plus.circle")

        let loader = AsyncImageLoader(url: url)
        let stubCache = CacheImpl<URL, Image>()
        stubCache[url] = expectedImage
        AsyncImageLoader.cache = AnyCache(data: stubCache)

        // when
        loader.load()

        // then
        XCTAssertEqual(loader.image!, expectedImage)
    }
}
