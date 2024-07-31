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
    
    // MARK: - UI
    private lazy var label = UILabel(type: .nameField, textFirstLine: titleLabel)
    private lazy var textField = CustomTextField(isPassword: isPassword)
    private lazy var eyeButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(.eye.withRenderingMode(.alwaysOriginal), for: .normal)
        return element
    }()
    
    // MARK: - Init
    init(frame: CGRect = .zero, titleLabel: String, isPassword: Bool) {
        self.titleLabel = titleLabel
        self.isPassword = isPassword
        
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
