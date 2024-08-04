//
//  FavoritesVC.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 29.07.2024.
//

import UIKit
import SnapKit
import RxSwift
import RxGesture
import RxCocoa

final class FavoritesVC: UIViewController {
    
    var onDetail = PublishRelay<Void>()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("detail view", for: .normal)
        return button
    }()
    
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        title = "FavoritesVC"
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        button.rx.tapGesture()
            .when(.recognized)
            .mapToVoid()
            .bind(to: onDetail)
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("Deinit \(type(of: self))")
    }
}

