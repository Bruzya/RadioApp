//
//  AppDIContainer.swift
//  RadioApp
//
//  Created by dsm 5e on 29.07.2024.
//

import Foundation

final class AppDIContainer {
    let firebase = FirebaseService()
    let realm = RealmService()
    let network = NetworkService()
}
