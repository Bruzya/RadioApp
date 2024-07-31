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
    private lazy var playImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.image = .playNavigation
        return element
    }()
    private let customBackgroundView = CustomBackgroundView(frame: .zero)
    private let titleView = TitleView(frame: .zero, isSignTitle: true)
    let emailView = TextFieldWithTitleView(
        titleLabel: "Email",
        isPassword: false
    )
    let passwordView = TextFieldWithTitleView(
        titleLabel: "Password",
        isPassword: true
    )
    private lazy var forgotPasswordButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Forgot Password ?", for: .normal)
        element.titleLabel?.font = Font.getFont(.displayRegular, size: 14)
        element.tintColor = .white
        return element
    }()
    private let connectWithGoogleView = ConnectWithGoogleView(frame: .zero)
    private let signButtonsView = SignButtonsView(title: .signUp)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("SignInView is failed init")
    }
    
    // MARK: - Public methods
    func setDelegates(controller: SignInViewController) {
        [emailView, passwordView].forEach {
            $0.textField.delegate = controller
        }
    }
    
    func setTargetForButton(controller: SignInViewController) {
        forgotPasswordButton.addTarget(
            controller,
            action: #selector(controller.didTapForgotPassButton),
            for: .touchUpInside
        )
        connectWithGoogleView.googleAuthButton.addTarget(
            controller,
            action: #selector(controller.didTapGoogleAuthButton),
            for: .touchUpInside
        )
        signButtonsView.nextButton.addTarget(
            controller,
            action: #selector(controller.didTapSignInButton),
            for: .touchUpInside
        )
        signButtonsView.signButton.addTarget(
            controller,
            action: #selector(controller.didTapSignUpButton),
            for: .touchUpInside
        )
    }
    
    // MARK: - Private methods
    private func setupView() {
        [
            customBackgroundView,
            playImageView,
            titleView,
            emailView,
            passwordView,
            forgotPasswordButton,
            connectWithGoogleView,
            signButtonsView
        ].forEach {
            addSubview($0)
        }
    }
}

// MARK: - Setup Constraints
private extension SignInView {
    func setupConstraints() {
        customBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        playImageView.snp.makeConstraints { make in
            make.width.height.equalTo(58)
            make.leading.equalToSuperview().offset(43)
            make.top.equalToSuperview().offset(112)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(playImageView.snp.bottom).offset(35.43)
            make.leading.equalTo(playImageView)
        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(21.51)
            make.leading.equalToSuperview().offset(38)
            make.trailing.equalToSuperview().offset(-38)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(21.51)
            make.leading.trailing.equalTo(emailView)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.trailing.equalTo(passwordView.snp.trailing)
            make.top.equalTo(passwordView.snp.bottom).offset(17.64)
        }
        
        connectWithGoogleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(59.2)
            make.trailing.equalToSuperview().offset(-59.2)
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(21.51)
        }
        
        signButtonsView.snp.makeConstraints { make in
            make.top.equalTo(connectWithGoogleView.snp.bottom).offset(42.11)
            make.leading.equalToSuperview().offset(37.23)
        }
    }
}

