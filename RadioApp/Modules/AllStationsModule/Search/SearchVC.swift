//
//  SearchVC.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 29.07.2024.
//

import UIKit
import SnapKit

final class SearchVC: UIViewController {
    
    private let allStations = AllStationsVC()
    
    // MARK: - UI Properties
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField(rightButtonImage: Search.result.image, target: self, action: #selector(toAllStation))
        return textField
    }()
    
    private let radioTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Selectors
    @objc private func toAllStation() {
        navigationController?.popViewController(animated: true)
    }
}


