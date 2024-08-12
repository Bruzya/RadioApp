//
//  CustomTF.swift
//  RadioApp
//
//  Created by Алексей on 08.08.2024.
//

import UIKit
import SnapKit

final class CustomTF: UIView {

    // MARK: - Private properties
    private let titleLabel: String
    
    // MARK: - UI
    lazy var backViewPasswordTextField: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    lazy var textFieldPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = titleLabel
        label.font = Font.getFont(.displayMedium, size: 14)
        label.backgroundColor = UIColor(red: 31/255, green: 29/255, blue: 43/255, alpha: 1.0)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var textFieldPassword: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Your password"
        tf.isSecureTextEntry = true
        tf.setPlaceholderColor(.gray, textField: tf)
        tf.textColor = .white
        return tf
    }()
    
    private lazy var eyeButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(.eye.withRenderingMode(.alwaysOriginal), for: .normal)
        element.addTarget(self, action: #selector(toggleShowPassword), for: .touchUpInside)
        return element
    }()
    
    // MARK: - Init
    init(frame: CGRect = .zero, titleLabel: String) {
        self.titleLabel = titleLabel
        
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupViews() {
        addSubview(backViewPasswordTextField)
        addSubview(textFieldPasswordLabel)
        backViewPasswordTextField.addSubview(textFieldPassword)
        addSubview(eyeButton)
    }
    
    // MARK: - Actions
    @objc private func toggleShowPassword() {
        textFieldPassword.isSecureTextEntry.toggle()
    }
}

// MARK: - Setup Constraints
private extension CustomTF {
    func setupConstraints() {
        backViewPasswordTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        textFieldPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(backViewPasswordTextField.snp.top).inset(-7)
            make.leading.equalTo(backViewPasswordTextField.snp.leading).inset(15)
        }
        
        textFieldPassword.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.height.equalToSuperview()
            make.trailing.equalTo(eyeButton.snp.leading).offset(-10)
        }
        
        eyeButton.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.trailing.equalTo(backViewPasswordTextField.snp.trailing).offset(-20)
            make.centerY.equalTo(backViewPasswordTextField)
        }
    }
}
