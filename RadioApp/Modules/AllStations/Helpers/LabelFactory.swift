//
//  LabelFactory.swift
//  RadioApp
//
//  Created by Alexander Bokhulenkov on 31.07.2024.
//

import UIKit


final class LabelFactory {
    
    static func createColorText(for string: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
            
        if string.contains("Hello") {
            if let range = string.range(of: "Hello") {
                let nsRange = NSRange(range, in: string)
                attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: nsRange)
            }
        }
        return attributedString
    }
}
