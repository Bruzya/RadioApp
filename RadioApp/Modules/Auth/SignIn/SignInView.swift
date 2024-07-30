//
//  SignInView.swift
//  RadioApp
//
//  Created by Алексей on 30.07.2024.
//

import UIKit
import SnapKit

final class SignInView: UIView {
    
    // MARK: - UI
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.image = .background
        return element
    }()
    
    private lazy var playImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.image = .playNavigation
        return element
    }()
    
    private lazy var polygonImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.image = .authPolygon
        return element
    }()
    
    private let titleLabel = UILabel(text: "SignIn", type: .title)
    
    private let subtitleLabel = UILabel(text: "to start play", type: .subtitle)
    
    private let emailLabel = UILabel(text: "Email", type: .nameField)
    
    private let emailTextField = UITextField(isPassword: false)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("SignInView is failed init")
    }
    
    // MARK: - Private methods
    private func setupView() {
        [
            backgroundImageView,
            playImageView,
            polygonImageView,
            titleLabel,
            subtitleLabel,
            emailLabel,
            emailTextField
        ].forEach {
            addSubview($0)
        }
    }
}

// MARK: - Setup Constraints
private extension SignInView {
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        playImageView.snp.makeConstraints { make in
            make.width.height.equalTo(58)
            make.leading.equalToSuperview().offset(43)
            make.top.equalToSuperview().offset(112)
        }
        
        polygonImageView.snp.makeConstraints { make in
            make.top.equalTo(playImageView)
            make.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(playImageView.snp.bottom).offset(35.43)
            make.leading.equalTo(playImageView)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(21.51)
            make.leading.equalTo(subtitleLabel)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(53)
            make.leading.equalToSuperview().offset(38)
            make.trailing.equalToSuperview().offset(-38)
            make.top.equalTo(emailLabel.snp.bottom).offset(14.83)
        }
    }
}

