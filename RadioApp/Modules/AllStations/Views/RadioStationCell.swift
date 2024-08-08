//
//  RadioStationCell.swift
//  RadioApp
//
//  Created by Alexander Bokhulenkov on 30.07.2024.
//

import UIKit

class RadioStationCell: UITableViewCell {
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2.0
        view.layer.borderColor = Colors.grey.cgColor
        view.layer.cornerRadius = 10
        view.clipsToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Font.getFont(Font.displayBold, size: 24)
        label.textColor = Colors.white
        label.numberOfLines = 2
//        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Font.getFont(Font.displayMedium, size: 14)
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
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            conteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            nameLabel.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -100),
            
            tagLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            tagLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 22),
            tagLabel.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -46),
            
            votesLabel.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 12),
            votesLabel.trailingAnchor.constraint(equalTo: likeButtons.leadingAnchor, constant: -4),
            
            likeButtons.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 10),
            likeButtons.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func likeTaped() {
        if likeButtons.currentImage == UIImage(named: "likeFilled") {
            likeButtons.setImage(UIImage(named: "like"), for: .normal)
        } else {
            likeButtons.setImage(UIImage(named: "likeFilled"), for: .normal)
//            добавить votes
            
        }
    }
    
    // MARK: - Set CellView
    
    private func setView() {
        
        contentView.addSubview(conteinerView)
        
        conteinerView.addSubview(tagLabel)
        conteinerView.addSubview(nameLabel)
        conteinerView.addSubview(votesLabel)
        conteinerView.addSubview(likeButtons)
    }
    
    
    func configure(with viewModel: RadioStationViewModel) {
        tagLabel.text = viewModel.tag
        nameLabel.text = viewModel.name
        votesLabel.text = "\(K.votes) \(viewModel.votes)"
    }
    
    func selectCell() {
        conteinerView.backgroundColor = Colors.pink
    }
    
    func deselectCell() {
        conteinerView.backgroundColor = .clear
    }
}
