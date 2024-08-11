//
//  User.swift
//  RadioApp
//
//  Created by Алексей on 07.08.2024.
//

import Foundation

final class User {
    static let shared = User()
    var name: String?
    var avatar: String?
    var email: String?
    
    var avatarUrl: URL? {
        if let avatar {
            return URL(string: avatar)
        } else {
            return nil
        }
    }
    
    var nameForHeader: String {
        "Hello " + (name ?? "User")
    }
}
