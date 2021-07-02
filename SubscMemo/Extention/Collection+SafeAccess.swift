//
//  Collection+SafeAccess.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/07/02.
//

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
