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
                    .font: UIFont.systemFont(ofSize: 50, weight: .bold)
                ]
            )
            attributedText.append(firstWord)
            let tab = NSAttributedString(string: "\n")
            attributedText.append(tab)
            let secondWord = NSAttributedString(
                string: String.localize(key: "toStartPlay"),
                attributes: [
                    .font: UIFont.systemFont(ofSize: 25, weight: .regular)
                ]
            )
            attributedText.append(secondWord)
            self.attributedText = attributedText
        case .titleForgotPass:
            let attributedText = NSMutableAttributedString()
            let firstWord = NSAttributedString(
                string: String.localize(key: "forgot"),
                attributes: [
                    .font: UIFont.systemFont(ofSize: 50, weight: .bold)
                ]
            )
            attributedText.append(firstWord)
            let tab = NSAttributedString(string: "\n")
            attributedText.append(tab)
            let secondWord = NSAttributedString(
                string: String.localize(key: "password"),
                attributes: [
                    .font: UIFont.systemFont(ofSize: 50, weight: .bold)
                ]
            )
            attributedText.append(secondWord)
            self.attributedText = attributedText
        case .nameField:
            self.text = textFirstLine
            self.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        case .connectWith:
            self.text = String.localize(key: "onConnect")
            self.textColor = UIColor(
                red: 141/255,
                green: 146/255,
                blue: 163/255,
                alpha: 1
            )
            self.font = UIFont.systemFont(ofSize: 11, weight: .bold)
            self.textAlignment = .center
        }
    }
}
