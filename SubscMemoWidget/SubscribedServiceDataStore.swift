//
//  SubscribedServiceDataStore.swift
//  SubscMemoWidget
//
//  Created by Higashihara Yoki on 2021/08/28.
//

import Foundation

protocol SubscribedServiceDataStore {
    var userDefault: KeyValueStore { get }
    var monthlyPayment: Int { get }
    var serviceCount: Int { get }
    var yearlyPayment: Int { get }
}

struct SubscribedServiceDataStoreImpl: SubscribedServiceDataStore {
    var userDefault: KeyValueStore

    var monthlyPayment: Int {
        userDefault.int(forKey: .cachedMonthlyPayment)
    }

    var serviceCount: Int {
        userDefault.int(forKey: .cachedServiceCount)
    }

    var yearlyPayment: Int {
        userDefault.int(forKey: .cachedYearlyPayment)
    }

    init(userDefaults: KeyValueStore = UserDefaults.init(suiteName: UserDefaultSuiteName.mysubscmemo.rawValue)!) {
        self.userDefault = userDefaults
    }
}
