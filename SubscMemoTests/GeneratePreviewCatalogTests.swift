//
//  GeneratePreviewCatalogTests.swift
//  SubscMemoTests
//
//  Created by Higashihara Yoki on 2021/09/24.
//

import XCTest
@testable import SubscMemo

import UIPreviewCatalog

class GeneratePreviewCatalogTests: XCTestCase {

    func testGenerateCatalog() {
        let catalog = UIPreviewCatalog(config: .defaultConfig)
        do {
            try catalog.createCatalog(previewItems: previewItems)
        } catch {
            print(error.localizedDescription)
            XCTFail("Failed UIPreviewCatalog")
        }
    }
}
