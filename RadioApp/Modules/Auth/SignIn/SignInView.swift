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
    let scrollView = UIScrollView()
    private let scrollViewContent = UIView()
    
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.image = .background
        element.backgroundColor = .black
        element.isUserInteractionEnabled = true
        return element
    }()
    
    private lazy var polygonImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.image = .authPolygon
        return element
    }()
    
    private lazy var playImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.image = .playNavigation
        return element
    }()

    private let titleView = TitleView(typeTytle: .signIn)
    let emailView = TextFieldWithTitleView(
        titleLabel: String.localize(key: "email"),
        isPassword: false
    )
    let passwordView = TextFieldWithTitleView(
        titleLabel: String.localize(key: "password"),
        isPassword: true
    )
    private lazy var forgotPasswordButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle(String.localize(key: "forgotPassword"), for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        element.tintColor = .white
        return element
    }()
    private let connectWithGoogleView = ConnectWithGoogleView()
    private let signButtonsView = SignButtonsView(title: .signUp)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        scrollView.delaysContentTouches = false
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
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(scrollView)
        scrollView.addSubview(scrollViewContent)
        [
            playImageView,
            polygonImageView,
            titleView,
            emailView,
            passwordView,
            forgotPasswordButton,
            connectWithGoogleView,
            signButtonsView
        ].forEach {
            scrollViewContent.addSubview($0)
        }
    }
}

// MARK: - Setup Constraints
private extension SignInView {
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollViewContent.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        playImageView.snp.makeConstraints { make in
            make.width.height.equalTo(58)
            make.leading.equalToSuperview().offset(43)
            make.top.equalToSuperview().offset(80)
        }
        
        polygonImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(40)
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
            make.leading.equalTo(passwordView.snp.leading)
        }
        
        scrollViewContent.snp.makeConstraints {
            $0.trailing.equalTo(backgroundImageView.snp.trailing)
            $0.bottom.equalTo(signButtonsView.snp.bottom).offset(40)
        }
    }
}

