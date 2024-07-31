//
//  SignUpView.swift
//  RadioApp
//
//  Created by Алексей on 31.07.2024.
//

import UIKit
import SnapKit

final class SignUpView: UIView {
    
    // MARK: - UI
    private lazy var playImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.image = .playNavigation
        return element
    }()
    
    private let customBackgroundView = CustomBackgroundView()
    
    private let titleView = TitleView(typeTytle: .signUp)
    
    let nameView = TextFieldWithTitleView(
        titleLabel: "Name",
        isPassword: false,
        placeholder: "Your name"
    )
    let emailView = TextFieldWithTitleView(
        titleLabel: "Email",
        isPassword: false
    )
    let passwordView = TextFieldWithTitleView(
        titleLabel: "Password",
        isPassword: true
    )
    private let signButtonsView = SignButtonsView(title: .signIn)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public methods
    func setDelegates(controller: SignUpViewController) {
        [nameView, emailView, passwordView].forEach {
            $0.textField.delegate = controller
        }
    }
    
    func setTargetForButton(controller: SignUpViewController) {
        signButtonsView.nextButton.addTarget(
            controller,
            action: #selector(controller.didTapSignUpButton),
            for: .touchUpInside
        )
        signButtonsView.signButton.addTarget(
            controller,
            action: #selector(controller.didTapSignInButton),
            for: .touchUpInside
        )
    }
    
    // MARK: - Private methods
    private func setupView() {
        [
            customBackgroundView,
            playImageView,
            titleView,
            nameView,
            emailView,
            passwordView,
            signButtonsView
        ].forEach {
            addSubview($0)
        }
    }
}

// MARK: - Setup Constraints
private extension SignUpView {
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

        nameView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(21.51)
            make.leading.equalToSuperview().offset(38)
            make.trailing.equalToSuperview().offset(-38)
        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(21.51)
            make.leading.trailing.equalTo(nameView)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(21.51)
            make.leading.trailing.equalTo(nameView)
        }
        
        signButtonsView.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(45.18)
            make.leading.equalTo(passwordView.snp.leading)
        }
    }
}
