//
//  ServiceIconImageViewTests.swift
//  SubscMemoTests
//
//  Created by Higashihara Yoki on 2021/08/10.
//

import XCTest
@testable import SubscMemo

class ServiceIconImageViewTests: XCTestCase {

    let faviconURL = URL(string: "https://www.google.com/s2/favicons")!
    let queryName = "domain_url"

    func testMakeFaviconURL_クエリなしのURLから正常にURLが生成される() {
        let iconImageView = ServiceIconImageView(iconColor: nil,
                                                 serviceURL: "",
                                                 serviceName: "")

        XCTContext.runActivity(named: "URL末尾の形式の差異") { _ in
            XCTContext.runActivity(named: "末尾が「/」") { _ in
                let yahooURL = "https://www.yahoo.com/"
                let result = iconImageView.makeFaviconURL(from: yahooURL)!
                let expectation = faviconURL.addQueryItem(name: queryName, value: "www.yahoo.com")!

                XCTAssertEqual(result, expectation)
            }

            XCTContext.runActivity(named: "末尾に/がつかない") { _ in
                let yahooURL = "https://www.yahoo.com"
                let result = iconImageView.makeFaviconURL(from: yahooURL)!
                let expectation = faviconURL.addQueryItem(name: queryName, value: "www.yahoo.com")!

                XCTAssertEqual(result, expectation)
            }
        }
    }

    func testMakeFaviconURL_クエリありのURLから正常にURLが生成される() {
        let iconImageView = ServiceIconImageView(iconColor: nil,
                                                 serviceURL: "",
                                                 serviceName: "")

        XCTContext.runActivity(named: "クエリが1つ") { _ in
            let yahooURL = "https://www.yahoo.com/?src=aaa"
            let result = iconImageView.makeFaviconURL(from: yahooURL)!
            let expectation = faviconURL.addQueryItem(name: queryName, value: "www.yahoo.com")!

            XCTAssertEqual(result, expectation)
        }

        XCTContext.runActivity(named: "クエリが2つ") { _ in
            let yahooURL = "https://www.yahoo.com/?src=aaa&bbb=cccc"
            let result = iconImageView.makeFaviconURL(from: yahooURL)!
            let expectation = faviconURL.addQueryItem(name: queryName, value: "www.yahoo.com")!

            XCTAssertEqual(result, expectation)
        }
    }

    func testMakeFaviconURL_パスパラメータありのURLから正常にURLが生成される() {
        let iconImageView = ServiceIconImageView(iconColor: nil,
                                                 serviceURL: "",
                                                 serviceName: "")

        XCTContext.runActivity(named: "パスが1つ") { _ in
            let yahooURL = "https://www.yahoo.com/aaaaa"
            let result = iconImageView.makeFaviconURL(from: yahooURL)!
            let expectation = faviconURL.addQueryItem(name: queryName, value: "www.yahoo.com")!

            XCTAssertEqual(result, expectation)
        }

        XCTContext.runActivity(named: "パスが2つ") { _ in
            let yahooURL = "https://www.yahoo.com/bbbbbb"
            let result = iconImageView.makeFaviconURL(from: yahooURL)!
            let expectation = faviconURL.addQueryItem(name: queryName, value: "www.yahoo.com")!

            XCTAssertEqual(result, expectation)
        }
    }

    func testMakeFaviconURL_スキームがhttps以外() {
        let iconImageView = ServiceIconImageView(iconColor: nil,
                                                 serviceURL: "",
                                                 serviceName: "")

        XCTContext.runActivity(named: "http://~") { _ in
            let yahooURL = "http://www.yahoo.com/"
            let result = iconImageView.makeFaviconURL(from: yahooURL)!
            let expectation = faviconURL.addQueryItem(name: queryName, value: "www.yahoo.com")!

            XCTAssertEqual(result, expectation)
        }
    }

    func testMakeFaviconURL_URL文字列が空の場合にnilとなる() {
        let iconImageView = ServiceIconImageView(iconColor: nil,
                                                 serviceURL: "",
                                                 serviceName: "")

        let URL = ""
        let result = iconImageView.makeFaviconURL(from: URL)

        XCTAssertNil(result)
    }
}
