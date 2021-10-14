//
//  SceneDelegate.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/10.
//

import AppTrackingTransparency
import Combine
import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private var cancellables = Set<AnyCancellable>()
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let contentView = MainTabView()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.setUpATT()
        }
    }

    private func setUpATT() {
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
