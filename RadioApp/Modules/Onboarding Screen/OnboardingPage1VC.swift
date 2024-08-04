//
//  OnboardingVC.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 29.07.2024.
//

import UIKit
import SnapKit

final class OnboardingPage1VC: UIViewController {
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    // MARK: - UI Properties
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = .background
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    private lazy var headerStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.alignment = .center
        element.spacing = 5
        element.distribution = .fillProportionally
        return element
    }()
    
    private lazy var firstHeaderLabel: UILabel = {
        let element = UILabel()
        element.text = "Let's Get Started"
        element.font = .systemFont(ofSize: 60, weight: .bold)
        element.textColor = .white
        return element
    }()
    
    private lazy var secondHeaderLabel: UILabel = {
        let element = UILabel()
        element.text = "Enjoy the best radio stations from your home? don't miss out on anything"
        element.font = .systemFont(ofSize: 16, weight: .regular)
        element.textColor = .white
        return element
    }()
    
    private lazy var getStartedButton: UIButton = {
        let element = UIButton()
        element.setTitle("Get started", for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        element.backgroundColor = UIColor(named: "pinkBase")
        element.layer.cornerRadius = 10
        element.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return element
    }()

    //    weak var coordinator: OnboardingCoordinator!
    //
    //    init(coordinator: OnboardingCoordinator!) {
    //        super.init(nibName: nil, bundle: nil)
    //        self.coordinator = coordinator
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(headerStackView)
        view.addSubview(getStartedButton)
        
        headerStackView.addArrangedSubview(firstHeaderLabel)
        headerStackView.addArrangedSubview(secondHeaderLabel)
    }
    // MARK: - Selector methods
    @objc private func continueButtonTapped() {
        print("continueButtonTapped")
        navigationController?.pushViewController(OnboardingPage2VC(), animated: true)
    }
    
    @objc private func skipButtonTapped() {
        print("skipButtonTapped")
    }
}

// MARK: - Setup Constraints
extension OnboardingPage1VC {
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        getStartedButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(80)
            make.width.equalTo(310)
            make.centerX.equalToSuperview()
        }
    }
}



