//
//  KeyNameSpaceable.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/24.
//

protocol KeyNameSpaceable {
    func namespaced<T: RawRepresentable>(_ key: T) -> String
}

extension KeyNameSpaceable {
    func namespaced<T: RawRepresentable>(_ key: T) -> String {
        return "\(Self.self).\(key.rawValue)"
    }
}
