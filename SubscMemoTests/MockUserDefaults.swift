//
//  MockUserDefaults.swift
//  SubscMemoTests
//
//  Created by Higashihara Yoki on 2021/08/24.
//

@testable import SubscMemo
import Foundation

class MockUserDefaults {
    private var mockDictionary: [String: Any] = [ : ]
}

extension MockUserDefaults: KeyValueStore {

    func registerDefaultValue() {
    }

    func set(_ value: String, forKey key: UserDefaultKeys) {
        let key = namespaced(key)
        mockDictionary[key] = value
    }

    func set(_ value: Int, forKey key: UserDefaultKeys) {
        let key = namespaced(key)
        mockDictionary[key] = value
    }

    func set(_ value: [Any], forKey key: UserDefaultKeys) {
        let key = namespaced(key)
        mockDictionary[key] = value
    }

    func set(_ value: Bool, forKey key: UserDefaultKeys) {
        let key = namespaced(key)
        mockDictionary[key] = value
    }

    func set(_ value: [Int: Int], forKey key: UserDefaultKeys) {
        let key = namespaced(key)
        mockDictionary[key] = value
    }

    func removeObject(forKey key: UserDefaultKeys) {
        let key = namespaced(key)
        mockDictionary.removeValue(forKey: key)
    }

    @discardableResult
    func string(forKey key: UserDefaultKeys) -> String? {
        let key = namespaced(key)
        return mockDictionary[key] as? String
    }

    @discardableResult
    func int(forKey key: UserDefaultKeys) -> Int {
        let key = namespaced(key)
        return (mockDictionary[key] as? Int) ?? 0
    }

    @discardableResult
    func array(forKey key: UserDefaultKeys) -> [Any]? {
        let key = namespaced(key)
        return mockDictionary[key] as? [Any]
    }

    @discardableResult
    func bool(forKey key: UserDefaultKeys) -> Bool {
        let key = namespaced(key)
        return mockDictionary[key] as? Bool ?? false
    }

    @discardableResult
    func dictionary(forKey key: UserDefaultKeys) -> [String: Any]? {
        let key = namespaced(key)
        return mockDictionary[key] as? [String: Any]
    }
}
