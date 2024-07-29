//
//  ContainerVC.swift
//  RadioApp
//
//  Created by dsm 5e on 30.07.2024.
//

import UIKit
import SnapKit
import RxSwift
import RxGesture

final class ContainerVC: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    var menuState: MenuState = .closed
    
    var navigationVC: UINavigationController?
    
    let menuVC = SideBarVC()
    let allStationsVC = AllStationsVC()
    let favoritesVC = FavoritesVC()
    let popularVC = PopularVC()
    
    private let button: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(resource: .playNavigation), for: .normal)
        return btn
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        addChildVCs()
        setupConstraints()
        setupBindings()
    }
    
    private func addChildVCs() {
        // menu
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        // allStations
        let navigationVC = UINavigationController(rootViewController: allStationsVC)
        addChild(navigationVC)
        view.addSubview(navigationVC.view)
        navigationVC.didMove(toParent: self)
        self.navigationVC = navigationVC
        
        view.addSubview(button)
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
                        } completion: { done in
                            if done {
                                self.menuState = .closed
                            }
                        }
                }
            })
            .disposed(by: disposeBag)
    }
}

private extension ContainerVC {
    func setupUI() {
        
    }
    
    func addSubviews() {
        
    }
    
    func setupConstraints() {
        button.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(23)
            make.size.equalTo(33)
        }
    }
}
