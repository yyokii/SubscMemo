//
//  CategoryPieChartViewModelTests.swift
//  SubscMemoTests
//
//  Created by Higashihara Yoki on 2021/08/12.
//

import XCTest
@testable import SubscMemo

class CategoryPieChartViewModelTests: XCTestCase {

    let vm = CategoryPieChartViewModel()

    // swiftlint:disable function_body_length
    func testArrangePieChartDatas_カテゴリー数が多い順になっている() {
        let subscCategories: [SubscCategory] = [
            SubscCategory(id: "id-01",
                          categoryID: "categoryID-01",
                          iconImageURL: "",
                          name: "category01"),
            SubscCategory(id: "id-02",
                          categoryID: "categoryID-02",
                          iconImageURL: "",
                          name: "category02"),
            SubscCategory(id: "id-03",
                          categoryID: "categoryID-03",
                          iconImageURL: "",
                          name: "category03")
        ]

        XCTContext.runActivity(named: "元データのカテゴリーがランダムな順の場合") { _ in

            /*
             categoryID-01: 1つ
             categoryID-02: 2つ
             categoryID-03: 3つ
             */
            let subscItems: [SubscribedItem] = [
                SubscribedItem(
                    categoryIDs: ["categoryID-03"],
                    cycle: "monthly",
                    description: "description",
                    id: "demo-01",
                    isUserOriginal: false,
                    memo: "demo-memo",
                    name: "demo-01",
                    planID: nil,
                    planName: "",
                    price: 100,
                    payAt: nil,
                    serviceID: "",
                    serviceURL: ""
                ),
                SubscribedItem(
                    categoryIDs: ["categoryID-01"],
                    cycle: "monthly",
                    description: "description",
                    id: "demo-01",
                    isUserOriginal: false,
                    memo: "demo-memo",
                    name: "demo-01",
                    planID: nil,
                    planName: "",
                    price: 100,
                    payAt: nil,
                    serviceID: "",
                    serviceURL: ""
                ),
                SubscribedItem(
                    categoryIDs: ["categoryID-02"],
                    cycle: "monthly",
                    description: "description",
                    id: "demo-01",
                    isUserOriginal: false,
                    memo: "demo-memo",
                    name: "demo-01",
                    planID: nil,
                    planName: "",
                    price: 100,
                    payAt: nil,
                    serviceID: "",
                    serviceURL: ""
                ),
                SubscribedItem(
                    categoryIDs: ["categoryID-03"],
                    cycle: "monthly",
                    description: "description",
                    id: "demo-01",
                    isUserOriginal: false,
                    memo: "demo-memo",
                    name: "demo-01",
                    planID: nil,
                    planName: "",
                    price: 100,
                    payAt: nil,
                    serviceID: "",
                    serviceURL: ""
                ),
                SubscribedItem(
                    categoryIDs: ["categoryID-02"],
                    cycle: "monthly",
                    description: "description",
                    id: "demo-01",
                    isUserOriginal: false,
                    memo: "demo-memo",
                    name: "demo-01",
                    planID: nil,
                    planName: "",
                    price: 100,
                    payAt: nil,
                    serviceID: "",
                    serviceURL: ""
                ),
                SubscribedItem(
                    categoryIDs: ["categoryID-03"],
                    cycle: "monthly",
                    description: "description",
                    id: "demo-01",
                    isUserOriginal: false,
                    memo: "demo-memo",
                    name: "demo-01",
                    planID: nil,
                    planName: "",
                    price: 100,
                    payAt: nil,
                    serviceID: "",
                    serviceURL: ""
                )
            ]

            let result = vm.arrangePieChartDatas(subscItems: subscItems, categories: subscCategories)
            XCTAssertEqual(result[0].label, "category03")
            XCTAssertEqual(result[0].data, 3)
            XCTAssertEqual(result[1].label, "category02")
            XCTAssertEqual(result[1].data, 2)
            XCTAssertEqual(result[2].label, "category01")
            XCTAssertEqual(result[2].data, 1)
        }
    }
}
