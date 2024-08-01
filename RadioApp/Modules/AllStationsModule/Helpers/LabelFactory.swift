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
            
        if string.contains("Mark") {
            if let range = string.range(of: "Mark") {
                let nsRange = NSRange(range, in: string)
                attributedString.addAttribute(.foregroundColor, value: Colors.pink, range: nsRange)
            }
        }
        return attributedString
    }
}
