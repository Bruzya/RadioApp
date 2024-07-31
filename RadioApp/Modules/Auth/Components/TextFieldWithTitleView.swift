//
//  TextFieldWithTitle.swift
//  RadioApp
//
//  Created by Алексей on 31.07.2024.
//

import UIKit
import SnapKit

final class TextFieldWithTitleView: UIView {

    // MARK: - Private properties
    private let titleLabel: String
    private let isPassword: Bool
    private var placeholder: String?
    
    // MARK: - UI
    private lazy var label = UILabel(type: .nameField, textFirstLine: titleLabel)
    lazy var textField = CustomTextField(isPassword: isPassword, placeholder: placeholder)
    private lazy var eyeButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(.eye.withRenderingMode(.alwaysOriginal), for: .normal)
        element.addTarget(self, action: #selector(toggleShowPassword), for: .touchUpInside)
        return element
    }()
    
    // MARK: - Init
    init(
        frame: CGRect = .zero,
        titleLabel: String,
        isPassword: Bool,
        placeholder: String? = nil
    ) {
        self.titleLabel = titleLabel
        self.isPassword = isPassword
        self.placeholder = placeholder
        
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupViews() {
        addSubview(label)
        addSubview(textField)
        addSubview(eyeButton)
        
        textField.rightViewPadding = 21.5
        if self.isPassword {
            textField.rightView = eyeButton
        }
    }
    
    // MARK: - Actions
    @objc private func toggleShowPassword() {
        textField.isSecureTextEntry.toggle()
    }
}

// MARK: - Setup Constraints
private extension TextFieldWithTitleView {
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(2.73)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(14.83)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(53)
        }
        
        snp.makeConstraints { make in
            make.bottom.equalTo(textField.snp.bottom)
        }
    }
}
