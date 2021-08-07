//
//  UNUserNotificationCenter+Combine.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/07.
//

import Combine
import UserNotifications

extension UNUserNotificationCenter {
    func getNotificationSettings() -> Future<UNNotificationSettings, Never> {
        return Future { promise in
            self.getNotificationSettings { settings in
                promise(.success(settings))
            }
        }
    }

    func requestAuthorization(options: UNAuthorizationOptions) -> Future<Bool, Error> {
        return Future { promise in
            self.requestAuthorization(options: options) { result, error in
                if let error = error {
                    promise(.failure(error)) } else {
                        promise(.success(result))
                    }
            }
        }
    }
}
