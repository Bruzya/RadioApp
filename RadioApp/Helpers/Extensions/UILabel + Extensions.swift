//
//  UIKit + Extensions.swift
//  RadioApp
//
//  Created by Алексей on 30.07.2024.
//

import UIKit

extension UILabel {
    enum TypeLabel {
        case titleSign(String)
        case titleForgotPass
        case nameField
        case connectWith
    }
    
    convenience init(type: TypeLabel, textFirstLine: String? = nil) {
        self.init()
        self.textColor = .white
        self.numberOfLines = 0
        switch type {
        case .titleSign(let text):
            let attributedText = NSMutableAttributedString()
            let firstWord = NSAttributedString(
                string: text,
                attributes: [
                    .font: Font.getFont(.displayBold, size: 50)
                ]
            )
            attributedText.append(firstWord)
            let tab = NSAttributedString(string: "\n")
            attributedText.append(tab)
            let secondWord = NSAttributedString(
                string: "to start play",
                attributes: [
                    .font: Font.getFont(.displayRegular, size: 25)
                ]
            )
            attributedText.append(secondWord)
            self.attributedText = attributedText
        case .titleForgotPass:
            let attributedText = NSMutableAttributedString()
            let firstWord = NSAttributedString(
                string: "Forgot",
                attributes: [
                    .font: Font.getFont(.displayBold, size: 50)
                ]
            )
            attributedText.append(firstWord)
            let tab = NSAttributedString(string: "\n")
            attributedText.append(tab)
            let secondWord = NSAttributedString(
                string: "Password",
                attributes: [
                    .font: Font.getFont(.displayBold, size: 50)
                ]
            )
            attributedText.append(secondWord)
            self.attributedText = attributedText
        case .nameField:
            self.text = textFirstLine
            self.font = Font.getFont(.displayMedium, size: 16)
        case .connectWith:
            self.text = "Or connect with"
            self.textColor = UIColor(
                red: 141/255,
                green: 146/255,
                blue: 163/255,
                alpha: 1
            )
            self.font = Font.getFont(.displayBold, size: 11)
            self.textAlignment = .center
        }
    }
}
