//
//  ContainerVC.swift
//  RadioApp
//
//  Created by dsm 5e on 30.07.2024.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

final class ContainerVC: UIViewController {

    var onProfileTap = PublishRelay<Void>()
    
    enum MenuState {
        case opened
        case closed
    }

    var menuState: MenuState = .closed

    var navigationVC: UINavigationController?

    private let menuVC = SideBarVC()
    private let allStationsVC = StationsVC()
    private let favoritesVC = FavoritesVC()
    private let popularVC = PopularVC()
    private let player = PlayerView()
    private let headerView = HeaderView()

    private let button: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(resource: .playNavigation), for: .normal)
        return btn
    }()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVCs()
        setupUI()
        setupBindings()
    }
    
    private func addChildVCs() {
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        navigationVC = UINavigationController(rootViewController: allStationsVC)
        navigationVC?.delegate = self
        guard let navigationVC = navigationVC else { return }
        addChild(navigationVC)
        view.addSubview(navigationVC.view)
        navigationVC.didMove(toParent: self)
    }
    

    private func setupBindings() {
        button.rx.tap
            .bind(onNext: { [unowned self] in
                switch menuState {
                case .closed:
                    UIView.animate(
                        withDuration: 0.5,
                        delay: 0,
                        usingSpringWithDamping: 0.8,
                        initialSpringVelocity: 0,
                        options: .curveEaseInOut) {
                            self.navigationVC?.view.frame.origin.x = UIScreen.main.bounds.width / 5
                            self.player.frame.origin.x = UIScreen.main.bounds.width / 2
                        } completion: { done in
                            if done {
                                self.menuState = .opened
                            }
                        }
                case .opened:
                    UIView.animate(
                        withDuration: 0.5,
                        delay: 0,
                        usingSpringWithDamping: 0.8,
                        initialSpringVelocity: 0,
                        options: .curveEaseInOut) {
                            self.navigationVC?.view.frame.origin.x = 0
                            self.player.frame.origin.x = UIScreen.main.bounds.width / 5
                        } completion: { done in
                            if done {
                                self.menuState = .closed
                            }
                        }
                }
            })
            .disposed(by: disposeBag)

        menuVC.onCellTap = { [unowned self] option in
            let currentVC = self.navigationVC?.viewControllers.last
            switch option {
            case .allStation:
                if currentVC != allStationsVC {
                    self.navigationVC?.setViewControllers([allStationsVC], animated: true)
                }
            case .favorite:
                if currentVC != favoritesVC {
                    self.navigationVC?.setViewControllers([favoritesVC], animated: true)
                }
            case .popular:
                if currentVC != popularVC {
                    self.navigationVC?.setViewControllers([popularVC], animated: true)
                }
            }

            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .curveEaseInOut) {
                    self.navigationVC?.view.frame.origin.x = 0
                    self.player.frame.origin.x = UIScreen.main.bounds.width / 5
                } completion: { done in
                    if done {
                        self.menuState = .closed
                    }
                }
        }
        
        headerView.profileImage.rx
            .tapGesture()
            .when(.recognized)
            .mapToVoid()
            .bind(to: onProfileTap)
            .disposed(by: disposeBag)
    }
}


private extension ContainerVC {
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(button)
        view.addSubview(player)
        view.addSubview(headerView)
    }
    
    func setupConstraints() {
        button.snp.makeConstraints { make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide)
                .offset(10)
            make
                .leading
                .equalToSuperview()
                .inset(23)
            make
                .size
                .equalTo(33)
        }
        
        headerView.snp.makeConstraints { make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide)
            make
                .leading
                .equalTo(button.snp.trailing)
                .offset(20)
            make
                .trailing
                .equalToSuperview()
                .inset(20)
        }

        player.snp.makeConstraints { make in
            make
                .leading.trailing
                .equalToSuperview()
                .inset(75)
            make
                .bottom
                .equalTo(view.safeAreaLayoutGuide)
        }
    }
}
