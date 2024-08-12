//
//  AppCoordinator.swift
//  RadioApp
//
//  Created by dsm 5e on 30.07.2024.
//

import UIKit
import RxCocoa
import RxSwift

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var window: UIWindow?
    
    var appDIContainer: AppDIContainer
    
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, window: UIWindow?, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.window = window
        self.appDIContainer = appDIContainer
    }
    
    //    func start() {
    //        configWindow()
    //        appDIContainer.firebase.isAuthorized ? makeMainFlow() : makeAuthFlow()
    //    }
    //
    //    private func configWindow() {
    //        window?.rootViewController = navigationController
    //        window?.makeKeyAndVisible()
    //    }
    //
    //    func makeOnboardingFlow() {
    //        let vc = OnboardingMainVC()
    //        vc
    //    }
    
    func start() {
        configWindow()
        appDIContainer.firebase.isAuthorized ? makeOnboardingFlow() : makeAuthFlow()
    }
    
    private func configWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func makeOnboardingFlow() {
        let vc = OnboardingMainVC()
        vc.onComplete = { [weak self] in
            self?.makeAuthFlow()
        }
        navigationController.setViewControllers([vc], animated: false)
    }
    
    
    func makeAuthFlow() {
        let vc = SignInViewController()
        vc.onSignIn = { [unowned self] in
            makeMainFlow()
        }
        navigationController.setViewControllers([vc], animated: false)
        navigationController.navigationBar.isHidden = true
    }
    
    func makeMainFlow() {
        let vc = ContainerVC()
        vc.onProfileTap
            .bind(onNext: { [unowned self] in
                makeProfileFlow()
            })
            .disposed(by: disposeBag)
        navigationController.setViewControllers([vc], animated: true)
        navigationController.navigationBar.isHidden = false
    }
    
    func makeProfileFlow() {
        let vc = SettingsVC()
        vc.onLogout = { [unowned self] in
            makeAuthFlow()
        }
        navigationController.pushViewController(vc, animated: true)
        navigationController.navigationBar.isHidden = false
    }
}
