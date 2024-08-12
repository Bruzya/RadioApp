//
//  SideBarController.swift
//  RadioApp
//
//  Created by dsm 5e on 29.07.2024.
//

import Foundation
import UIKit
import SnapKit


final class SideBarVC: UIViewController {
    
    var onCellTap: ((SideBarOption) -> Void)?
    
    enum SideBarOption: String, CaseIterable {
        case allStation
        case favorite
        case popular
        
        var localizeString: String {
            switch self{
            case .allStation:
                return String.localize(key: "allStation")
            case .favorite:
                return String.localize(key: "favorites")
            case .popular:
                return String.localize(key: "popular")
            }
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(SideBarCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        view.backgroundColor = UIColor(red: 8/225.0, green: 8/225.0, blue: 51/225.0, alpha: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top + 100,
            width: view.bounds.size.width / 4.5,
            height: view.bounds.size.height
        )
    }
}

extension SideBarVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SideBarOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideBarCell
        cell.label.text = SideBarOption.allCases[indexPath.item].localizeString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = SideBarOption.allCases[indexPath.row]
        onCellTap?(item)
    }
}
