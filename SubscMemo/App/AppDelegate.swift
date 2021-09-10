//
//  AppDelegate.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/10.
//

import AppTrackingTransparency
import Combine
import UIKit

import Firebase
import FirebaseAuth
import GoogleMobileAds
import Resolver

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    @LazyInjected var authenticationService: AuthenticationService
    private var cancellables = Set<AnyCancellable>()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self

        GADMobileAds.sharedInstance().start(completionHandler: nil)

        #if DEBUG
        if isTesting() {
            return true
        }
        #endif

        setUpUserNotification()
        setUpATT()

        authenticationService.setup()

        return true
    }

    func setUpUserNotification() {
        UNUserNotificationCenter.current()
            .getNotificationSettings()
            .flatMap { settings -> AnyPublisher<Bool, Never> in
                switch settings.authorizationStatus {
                case .notDetermined:
                    return UNUserNotificationCenter.current()
                        .requestAuthorization(options: [.alert, .sound, .badge])
                        .replaceError(with: false)
                        .eraseToAnyPublisher()
                case .denied:
                    return Just(false).eraseToAnyPublisher()
                default:
                    return Just(true).eraseToAnyPublisher()
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { hasPermissions in
                if hasPermissions == false { // point user to settings
                    UIApplication.shared.registerForRemoteNotifications()
                } else {
                    // we have permission
                }
            }).store(in: &cancellables)
    }

    func setUpATT() {
        ATTrackingManager
            .getAuthorizationStatus()
            .flatMap { status -> AnyPublisher<ATTrackingManager.AuthorizationStatus, Never> in
                switch status {
                case .authorized, .denied, .restricted:
                    return Just(status).eraseToAnyPublisher()
                case .notDetermined:
                    return ATTrackingManager
                        .requestAuthorization()
                        .eraseToAnyPublisher()
                @unknown default:
                    return Just(status).eraseToAnyPublisher()
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { status in
                print("📝: ATT stauts \(status.description)")
            }).store(in: &cancellables)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                    -> Void) {
        completionHandler([[.banner, .list, .sound]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("📝 fcmToken: \(fcmToken ?? "")")
    }
}
