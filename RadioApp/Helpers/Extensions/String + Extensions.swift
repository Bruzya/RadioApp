//
//  String + Extensions.swift
//  RadioApp
//
//  Created by Drolllted on 12.08.2024.
//

import Foundation


extension String {
    
    static func localize(key: String.LocalizationValue) -> String {
        return String(localized: key)
    }
    
}
