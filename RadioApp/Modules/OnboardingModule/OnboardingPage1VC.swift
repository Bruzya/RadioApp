//
//  OnboardingVC.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 29.07.2024.
//

import UIKit
import SnapKit

final class OnboardingPage1VC: UIViewController {
    
    var onNext: (() -> Void)?
    
    // MARK: - UI Properties
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = .woman
        element.contentMode = .scaleAspectFill
        element.layer.opacity = 0.9
        return element
    }()
    
    private lazy var secondBackgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = .background
        element.contentMode = .scaleAspectFill
        element.alpha = 0.9
        return element
    }()
    
    private lazy var headerStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.alignment = .leading
        element.spacing = 10
        element.distribution = .fillProportionally
        return element
    }()

    private lazy var firstHeaderLabel: UILabel = {
        let element = UILabel()
        element.text = String.localize(key: "startLabel")
        element.font = .systemFont(ofSize: 60, weight: .bold)
        element.textColor = .white
        element.textAlignment = .left
        element.numberOfLines = 0
        return element
    }()

    private lazy var secondHeaderLabel: UILabel = {
        let element = UILabel()
        element.text = String.localize(key: "descriptionLabel")
        element.font = .systemFont(ofSize: 16, weight: .regular)
        element.textColor = .white
        element.textAlignment = .left
        element.numberOfLines = 0
        element.lineBreakMode = .byWordWrapping
        return element
    }()
    
    private lazy var getStartedButton: UIButton = {
        let element = UIButton()
        element.setTitle(String.localize(key: "startButton"), for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        element.backgroundColor = UIColor(named: "pinkBase")
        element.layer.cornerRadius = 10
        element.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return element
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        view.backgroundColor = .blue
    }
    
    deinit {
        print("deinit")
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.addSubview(backgroundImageView)
        backgroundImageView.addSubview(secondBackgroundImageView)
        view.addSubview(headerStackView)
        view.addSubview(getStartedButton)
        
        headerStackView.addArrangedSubview(firstHeaderLabel)
        headerStackView.addArrangedSubview(secondHeaderLabel)
    }
    // MARK: - Selector methods
    @objc private func continueButtonTapped() {
        onNext?()
        print("continueButtonTapped")
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
        
        secondBackgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(100)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(90)
            make.width.equalTo(250)
        }
        
        secondHeaderLabel.snp.makeConstraints { make in
            make.width.equalTo(220)
        }
        
        getStartedButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(58)
            make.width.equalTo(310)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}



