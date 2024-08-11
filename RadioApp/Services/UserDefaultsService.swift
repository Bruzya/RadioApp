//
//  UserDefaultsService.swift
//  RadioApp
//
//  Created by Andrew Linkov on 03.08.2024.
//

import Foundation

final class  UserDefaultsService {
    
    static let shared = UserDefaultsService()
    
    private init() {}
    
    // MARK: - Булька для проверки прошел ли пользователь онбординг
    var isOnboarding: Bool {
        get { UserDefaults.standard.bool(forKey: "isOnboaring") }
        set { UserDefaults.standard.setValue(newValue, forKey: "isOnboaring") }
    }
}

