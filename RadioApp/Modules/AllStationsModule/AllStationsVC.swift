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
        
        NetworkService.shared.fetchAllStations { result in
            switch result {
            case .success(let stations):
                print(stations)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    deinit {
        print("Deinit \(type(of: self))")
    }
}
