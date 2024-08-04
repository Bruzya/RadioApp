//
//  AppCoordinator.swift
//  RadioApp
//
//  Created by dsm 5e on 30.07.2024.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var window: UIWindow?
    
    var appDIContainer: AppDIContainer?
    
    init(navigationController: UINavigationController, window: UIWindow?, appDIContainer: AppDIContainer?) {
        self.navigationController = navigationController
        self.window = window
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        configWindow()
        makeOnboardingFlow()
//        makeMainFlow()
    }
    
    private func configWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func makeOnboardingFlow() {
        let vc = OnboardingMainVC()
        vc.onComplete = { [weak self] in
            print ("main flow")
        }
        navigationController.setViewControllers([vc], animated: false)
        
    }
    
    
    func makeAuthFlow() {
        
    }
    
    func makeMainFlow() {
        let vc = ContainerVC()
        navigationController.setViewControllers([vc], animated: false)
    }
}
