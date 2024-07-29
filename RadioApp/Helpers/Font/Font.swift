//
//  Font.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 29.07.2024.
//

import UIKit

enum Font: String {
    
    case displayRegular = "SF-Pro-Display-Regular"
    case displayMedium = "SF-Pro-Display-Medium"
    case displayBold = "SF-Pro-Display-Bold"
    
    static func getFont(_ font: Font, size: CGFloat) -> UIFont {
        return UIFont(name: font.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
