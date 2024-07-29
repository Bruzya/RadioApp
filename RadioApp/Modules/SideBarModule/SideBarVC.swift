//
//  SideBarController.swift
//  RadioApp
//
//  Created by dsm 5e on 29.07.2024.
//

import Foundation
import UIKit
import SnapKit

class SideBarCell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        label.textColor = .white
        return label
    }()

    private let vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        vStack.addArrangedSubview(label)
        contentView.addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.width.equalTo(vStack.snp.height)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class SideBarVC: UIViewController {
    
    enum SideBarOption: String, CaseIterable {
        case allStation = "All Station"
        case favorite = "Favorite"
        case popular = "Popular"
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
        view.backgroundColor = UIColor(red: 8/225.0, green: 8/225.0, blue: 51/225.0, alpha: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top + 200,
            width: view.bounds.size.width / 4,
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
        cell.label.text = SideBarOption.allCases[indexPath.row].rawValue
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
