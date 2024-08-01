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
    
    private lazy var votesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = Font.getFont(Font.displayRegular, size: 14)
        label.textColor = Colors.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likeButtons: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "like"), for: .normal)
        button.addTarget(self, action: #selector(likeTaped), for: .touchUpInside)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setView()
        
        NSLayoutConstraint.activate([
            
            tagLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            tagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            
            nameLabel.topAnchor.constraint(equalTo: tagLabel.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -46),
            
            votesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            votesLabel.trailingAnchor.constraint(equalTo: likeButtons.leadingAnchor, constant: -4),
            
            likeButtons.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            likeButtons.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func likeTaped() {
        likeButtons.setImage(UIImage(named: "likeFilled"), for: .normal)
    }
    
    // MARK: - Set CellView
    
    private func setView() {
        contentView.addSubview(tagLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(votesLabel)
        contentView.addSubview(likeButtons)
    }
    
    
    func configure(with viewModel: RadioStationViewModel) {
        tagLabel.text = viewModel.name
        nameLabel.text = viewModel.tag
        votesLabel.text = "\(K.votes) \(viewModel.votes)"
    }
}
