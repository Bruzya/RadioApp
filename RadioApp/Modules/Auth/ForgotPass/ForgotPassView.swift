//
//  ForgotPassView.swift
//  RadioApp
//
//  Created by Алексей on 31.07.2024.
//

import UIKit
import SnapKit

final class ForgotPassView: UIView {
    
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
    
    private lazy var backButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(.back.withRenderingMode(.alwaysOriginal), for: .normal)
        return element
    }()
    
    private let titleView = TitleView(typeTytle: .forgotPass)
    
    let emailView = TextFieldWithTitleView(
        titleLabel: String.localize(key: "email"),
        isPassword: false
    )
    
    let passwordView = TextFieldWithTitleView(
        titleLabel: String.localize(key: "password"),
        isPassword: true
    )
    
    let confirmPasswordView = TextFieldWithTitleView(
        titleLabel: String.localize(key: "confirmPassword"),
        isPassword: true
    )
    
    let sentButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = .blueLight
        element.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        element.setTitleColor(.white, for: .normal)
        element.setTitle(String.localize(key: "sent"), for: .normal)
        return element
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setupConstraints()
        
        passwordView.alpha = 0
        confirmPasswordView.alpha = 0
        
        scrollView.delaysContentTouches = false
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public methods
    func setDelegates(controller: ForgotPassViewController) {
        [emailView, passwordView, confirmPasswordView].forEach {
            $0.textField.delegate = controller
        }
    }
    
    func setTargetForButton(controller: ForgotPassViewController) {
        backButton.addTarget(
            controller,
            action: #selector(controller.didTapBackButton),
            for: .touchUpInside
        )
        sentButton.addTarget(
            controller,
            action: #selector(controller.didTapSentButton(_:)),
            for: .touchUpInside
        )
    }
    
    func updateView() {
        UIView.animate(
            withDuration: 0.25) { [weak self] in
                guard let self else { return }
                emailView.alpha = 0
            } completion: { _ in
                UIView.animate(withDuration: 0.25) { [weak self] in
                    guard let self else { return }
                    passwordView.alpha = 1
                    confirmPasswordView.alpha = 1
                    
                    sentButton.frame = sentButton.frame.offsetBy(dx: 0, dy: 92)
                } completion: { [weak self] _ in
                    guard let self else { return }
                    sentButton.snp.makeConstraints { [weak self] make in
                        guard let self else { return }
                        make.top.equalTo(passwordView.snp.bottom).offset(160)
                        make.width.equalTo(emailView.snp.width)
                        make.height.equalTo(73)
                        make.centerX.equalToSuperview()
                    }
                }
            }
    }
    
    // MARK: - Private methods
    private func setViews() {
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(scrollView)
        scrollView.addSubview(scrollViewContent)
        [
            polygonImageView,
            backButton,
            titleView,
            emailView,
            passwordView,
            confirmPasswordView,
            sentButton,
        ].forEach {
            scrollViewContent.addSubview($0)
        }
    }
    
}

private extension ForgotPassView {
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
        
        backButton.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(27)
            make.leading.equalToSuperview().offset(43)
            make.top.equalToSuperview().offset(80)
        }
        
        polygonImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(40)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(35.43)
            make.leading.equalTo(backButton)
        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(21.51)
            make.leading.equalToSuperview().offset(38)
            make.trailing.equalToSuperview().offset(-38)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(21.51)
            make.leading.equalToSuperview().offset(38)
            make.trailing.equalToSuperview().offset(-38)
        }
        
        confirmPasswordView.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(21.51)
            make.leading.trailing.equalTo(passwordView)
        }
        
        sentButton.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(70)
            make.width.equalTo(emailView.snp.width)
            make.height.equalTo(73)
            make.centerX.equalToSuperview()
        }
        
        scrollViewContent.snp.makeConstraints {
            $0.trailing.equalTo(backgroundImageView.snp.trailing)
            $0.bottom.equalTo(sentButton.snp.bottom).offset(40)
        }
    }
}
