//
//  CustomTextField.swift
//  RadioApp
//
//  Created by Алексей on 31.07.2024.
//

import UIKit

final class CustomTextField: UITextField {

    var rightViewPadding: CGFloat = 0

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(isPassword: Bool, placeholder: String? = nil){
        self.init()
        setLeftPadding()
        self.rightViewMode = isPassword ? .always : .never
        if let text = placeholder {
            self.placeholder = text
        } else {
            self.placeholder = isPassword ? "Your password" : "Your email"
        }
        self.isSecureTextEntry = isPassword ? true : false
        self.textColor = .white

        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.pinkBase.cgColor
        self.layer.cornerRadius = 5
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
        
        let attributedPlaceholder = NSAttributedString(
            string: isPassword ? "Your password" : placeholder != nil ? placeholder! : "Your email",
            attributes: attributes
        )
        
        self.attributedPlaceholder = attributedPlaceholder
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Override methods
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= rightViewPadding
        return rightViewRect
    }
    
    // MARK: - Private methods
    private func setLeftPadding(size: CGFloat = 17.5) {
        self.leftView = UIView(
            frame: CGRect(
                x: self.frame.minX,
                y: self.frame.minY,
                width: size,
                height: self.frame.height
            )
        )
        self.leftViewMode = .always
    }

}
