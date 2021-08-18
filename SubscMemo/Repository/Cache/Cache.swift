//
//  Cache.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/06.
//

import Foundation

protocol Cache {
    associatedtype Key
    associatedtype Value

    subscript(key: Key) -> Value? { get set }
    func removeAll()
}

struct AnyCache<T: Cache> {
    let data: T
}

/// キャッシュ管理クラス。任意の値を保存でき、メモリキャッシュのみ対応。
final public class CacheImpl<Key: Hashable, Value>: Cache {
    var wrapped = NSCache<WrappedKey, Entry>()
    var dateProvider: () -> Date
    var entryLifetime: TimeInterval

    public init(dateProvider: @escaping () -> Date = Date.init,
                entryLifetime: TimeInterval = 12 * 60 * 60) {
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
    }

    subscript(key: Key) -> Value? {
        get { return value(forKey: key) }
        set {
            guard let value = newValue else {
                // 値がnilの場合は対象のキーを削除する
                removeValue(forKey: key)
                return
            }

            insert(value, forKey: key)
        }
    }

    func insert(_ value: Value, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(value: value, expirationDate: date)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }

    func value(forKey key: Key) -> Value? {
        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
            return nil
        }

        guard dateProvider() < entry.expirationDate else {
            // Discard values that have expired
            removeValue(forKey: key)
            return nil
        }

        return entry.value
    }

    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }

    func removeAll() {
        wrapped.removeAllObjects()
    }
}

extension CacheImpl {

    ///  Wrap our public-facing Key values in order to make them NSCache compatible.
    final class WrappedKey: NSObject {
        let key: Key

        init(_ key: Key) { self.key = key }

        override var hash: Int { return key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }

            return value.key == key
        }
    }

    final class Entry {
        let value: Value
        let expirationDate: Date

        init(value: Value, expirationDate: Date) {
            self.value = value
            self.expirationDate = expirationDate
        }
    }
}
