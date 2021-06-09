//
//  UIResponder+IsTesting.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/10.
//

import UIKit

extension UIResponder {

    func isTesting() -> Bool {
        return NSClassFromString("XCTest") != nil
    }
}
