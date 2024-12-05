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
        
    private let titleView = TitleView(typeTytle: .signUp)
    
    let nameView = TextFieldWithTitleView(
        titleLabel: String.localize(key: "name"),
        isPassword: false,
        placeholder: String.localize(key: "namePlaceholder")
    )
    let emailView = TextFieldWithTitleView(
        titleLabel: String.localize(key: "email"),
        isPassword: false
    )
    let passwordView = TextFieldWithTitleView(
        titleLabel: String.localize(key: "password"),
        isPassword: true
    )
    private let signButtonsView = SignButtonsView(title: .signIn)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        scrollView.delaysContentTouches = false
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
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(scrollView)
        scrollView.addSubview(scrollViewContent)
        [
            playImageView,
            polygonImageView,
            titleView,
            nameView,
            emailView,
            passwordView,
            signButtonsView
        ].forEach {
            scrollViewContent.addSubview($0)
        }
    }
}

// MARK: - Setup Constraints
private extension SignUpView {
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
            make.top.equalToSuperview().offset(49)
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
        
        scrollViewContent.snp.makeConstraints {
            $0.trailing.equalTo(backgroundImageView.snp.trailing)
            $0.bottom.equalTo(signButtonsView.snp.bottom).offset(40)
        }
    }
}
