//
//  RadioStationCell.swift
//  RadioApp
//
//  Created by Alexander Bokhulenkov on 30.07.2024.
//

import UIKit

class RadioStationCell: UITableViewCell {
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Font.getFont(Font.displayBold, size: 24)
        label.textColor = Colors.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Font.getFont(Font.displayRegular, size: 14)
        label.textColor = Colors.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set CellView
    
    private func setView() {
        contentView.addSubview(tagLabel)
        contentView.addSubview(nameLabel)
    }
    
    
    func configure(with viewModel: RadioStationViewModel) {
        tagLabel.text = viewModel.name
        nameLabel.text = viewModel.tag
    }
}
