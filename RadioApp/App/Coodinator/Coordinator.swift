//
//  Coordinator.swift
//  RadioApp
//
//  Created by dsm 5e on 30.07.2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
