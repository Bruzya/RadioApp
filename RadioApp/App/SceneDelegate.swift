//
//  SceneDelegate.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 29.07.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appDIContainer: AppDIContainer?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
//        window?.rootViewController = StationsVC()
//        window?.makeKeyAndVisible()
        appDIContainer = AppDIContainer()
        appCoordinator = AppCoordinator(
            navigationController: UINavigationController(),
            window: window,
            appDIContainer: appDIContainer
        )
        
        appCoordinator?.start()

    }
}
