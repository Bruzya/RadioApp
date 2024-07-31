//
//  UIKit + Extensions.swift
//  RadioApp
//
//  Created by Алексей on 30.07.2024.
//

import UIKit

extension UILabel {
    enum TypeLabel {
        case title
        case subtitle
        case nameField
        case connectWith
    }
    
    convenience init(text: String, type: TypeLabel) {
        self.init()    
        self.text = text
        switch type {
        case .title:
            self.textColor = .white
            self.font = Font.getFont(.displayBold, size: 50)
        case .subtitle:
            self.textColor = .white
            self.font = Font.getFont(.displayRegular, size: 25)
        case .nameField:
            self.textColor = .white
            self.font = Font.getFont(.displayMedium, size: 16)
        case .connectWith:
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
