//
//  SignButtons.swift
//  RadioApp
//
//  Created by Алексей on 31.07.2024.
//

import UIKit
import SnapKit

final class SignButtonsView: UIView {
    
    enum TypeSignButton: String {
        case signUp = "Or Sign Up"
        case signIn = "Or Sign In"
    }
    
    // MARK: - Private properties
    private let titleButton: String
    
    // MARK: - UI
    lazy var nextButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = .blueLight
        element.tintColor = .white
        element.setImage(.back, for: .normal)
        element.transform = CGAffineTransform(scaleX: -1, y: 1)
        return element
    }()
    
    lazy var signButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle(titleButton, for: .normal)
        element.titleLabel?.font = Font.getFont(.displayRegular, size: 20)
        element.tintColor = .white
        return element
    }()
    
    // MARK: - Init
    init(frame: CGRect = .zero, title: TypeSignButton) {
        self.titleButton = title.rawValue
        
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupViews() {
        addSubview(nextButton)
        addSubview(signButton)
    }
}

// MARK: - Setup Constraints
private extension SignButtonsView {
    func setupConstraints() {
        nextButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(153)
            make.height.equalTo(62)
        }
        
        signButton.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(21.51)
            make.leading.equalTo(nextButton.snp.leading).offset(8.04)
        }
        
        snp.makeConstraints { make in
            make.trailing.equalTo(nextButton.snp.trailing)
            make.bottom.equalTo(signButton.snp.bottom)
        }
    }
}
