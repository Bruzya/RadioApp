//
//  RadioStationCell.swift
//  RadioApp
//
//  Created by Alexander Bokhulenkov on 30.07.2024.
//

import UIKit

class RadioStationCell: UICollectionViewCell {
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
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setView()
        
        NSLayoutConstraint.activate([
                    tagLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                    tagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                    tagLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                    
                    nameLabel.topAnchor.constraint(equalTo: tagLabel.bottomAnchor, constant: 8),
                    nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                    nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                    nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
                ])
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
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
