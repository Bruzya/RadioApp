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
    
    private let connectWithLabel = UILabel(text: "Or connect with", type: .connectWith)
    
    private let passwordLabel = UILabel(text: "Password", type: .nameField)
    
    private let emailTextField = CustomTextField(isPassword: false)
    
    private let passwordTextField = CustomTextField(isPassword: true)
    
    private lazy var forgotPasswordButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Forgot Password ?", for: .normal)
        element.titleLabel?.font = Font.getFont(.displayRegular, size: 14)
        element.tintColor = .white
        return element
    }()
    
    private lazy var googleAuthButton: UIButton = {
        let element = UIButton(type: .system)
        element.setBackgroundImage(.google, for: .normal)
        return element
    }()
    
    private lazy var signInButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = .blueLight
        element.tintColor = .white
        element.setImage(.back, for: .normal)
        element.transform = CGAffineTransform(scaleX: -1, y: 1)
        return element
    }()
    
    private lazy var signUpButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Or Sign Up", for: .normal)
        element.titleLabel?.font = Font.getFont(.displayRegular, size: 20)
        element.tintColor = .white
        return element
    }()
    
    private lazy var eyeButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(.eye.withRenderingMode(.alwaysOriginal), for: .normal)
        return element
    }()
    
    private lazy var firstLine = makeLineView()
    private lazy var secondLine = makeLineView()
    
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
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewPadding = 21.5
        
        [
            backgroundImageView,
            playImageView,
            polygonImageView,
            titleLabel,
            subtitleLabel,
            emailLabel,
            emailTextField,
            passwordLabel,
            passwordTextField,
            forgotPasswordButton,
            connectWithLabel,
            firstLine,
            secondLine,
            googleAuthButton,
            signInButton,
            signUpButton,
        ].forEach {
            addSubview($0)
        }
    }
    
    // MARK: - Private methods
    private func makeLineView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(
            red: 141/255,
            green: 146/255,
            blue: 163/255,
            alpha: 1
        )
        return view
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
            make.top.equalTo(playImageView.snp.top).offset(-30)
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
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(21.51)
            make.leading.equalTo(emailLabel.snp.leading)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(emailTextField.snp.trailing)
            make.height.equalTo(53)
            make.top.equalTo(passwordLabel.snp.bottom).offset(14.83)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.trailing.equalTo(passwordTextField.snp.trailing)
            make.top.equalTo(passwordTextField.snp.bottom).offset(17.64)
        }
        
        firstLine.snp.makeConstraints { make in
            make.leading.equalTo(passwordTextField.snp.leading).offset(21.51)
            make.trailing.equalTo(connectWithLabel.snp.leading).offset(-17)
            make.height.equalTo(1)
            make.centerY.equalTo(connectWithLabel)
        }
        
        connectWithLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(21.51)
        }
        
        secondLine.snp.makeConstraints { make in
            make.leading.equalTo(connectWithLabel.snp.trailing).offset(17)
            make.trailing.equalTo(passwordTextField.snp.trailing).offset(-21.51)
            make.height.equalTo(1)
            make.centerY.equalTo(connectWithLabel)
        }
        
        googleAuthButton.snp.makeConstraints { make in
            make.width.height.equalTo(39.89)
            make.centerX.equalToSuperview()
            make.top.equalTo(connectWithLabel.snp.bottom).offset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.leading.equalTo(passwordTextField.snp.leading)
            make.height.equalTo(62)
            make.width.equalTo(153)
            make.top.equalTo(googleAuthButton.snp.bottom).offset(42.11)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.leading.equalTo(signInButton.snp.leading).offset(8)
            make.top.equalTo(signInButton.snp.bottom).offset(21.51)
        }
    }
}

