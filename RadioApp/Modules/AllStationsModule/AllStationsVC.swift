//
//  AllStationsVC.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 29.07.2024.
//

import UIKit

final class AllStationsVC: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 42/255, alpha: 1)
        title = "AllStationsVC"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    deinit {
        print("Deinit \(type(of: self))")
    }
}
