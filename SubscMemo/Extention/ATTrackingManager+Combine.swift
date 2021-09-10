//
//  ATTrackingManager+Combine.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/09/10.
//

import AppTrackingTransparency
import Combine

extension ATTrackingManager {

    static func getAuthorizationStatus() -> Future<AuthorizationStatus, Never> {
        return Future { promise in
            let status =  ATTrackingManager.trackingAuthorizationStatus
            promise(.success(status))
        }
    }

    static func requestAuthorization() -> Future<AuthorizationStatus, Never> {
        return Future { promise in
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                promise(.success(status))
            })
        }
    }
}

extension ATTrackingManager.AuthorizationStatus {
    public var description: String {
        switch self {
        case .authorized : return "authorized"
        case .denied : return "denied"
        case .restricted : return "restricted"
        case .notDetermined : return "notDetermined"
        @unknown default:
            return "unknown..."
        }
    }
}
