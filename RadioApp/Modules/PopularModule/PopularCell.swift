//
//  PopularCell.swift
//  RadioApp
//
//  Created by Алексей on 09.08.2024.
//

import UIKit
import SnapKit

final class PopularCell: UICollectionViewCell {
    
    // MARK: - UI
    private lazy var tagStationLabel = createLabel(fontSize: 30, fontwWeight: .bold)
    private lazy var nameStationLabel = createLabel(fontSize: 15, fontwWeight: .regular)
    private lazy var votesLabel = createLabel(fontSize: 10, fontwWeight: .bold)
    
    private lazy var playImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.image = .play
        element.isHidden = true
        return element
    }()
    
    private lazy var likeButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(resource: .like).withRenderingMode(.alwaysOriginal), for: .normal)
        element.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        return element
    }()
    
    private lazy var waveImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.image = .greyWave
        return element
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupViews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Overridess methods
    override var isSelected: Bool {
        didSet {
            toggleCell(isSelected)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playImageView.isHidden = true
    }
    
    // MARK: - Private methods
    private func setupViews() {
        [
            playImageView,
            tagStationLabel,
            nameStationLabel,
            votesLabel,
            likeButton,
            waveImageView
        ].forEach {
            addSubview($0)
        }
        
        votesLabel.text = "votes 1234"
        votesLabel.textAlignment = .right
        tagStationLabel.text = "POP"
        tagStationLabel.textAlignment = .center
        nameStationLabel.text = "Radio Record"
        nameStationLabel.textAlignment = .center
    }
    
    private func setupCell() {
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = Colors.anotherGray.cgColor
        backgroundColor = Colors.background
    }
    
    private func createLabel(
        color: UIColor = Colors.anotherGray,
        fontSize: CGFloat,
        fontwWeight: UIFont.Weight
    ) -> UILabel {
        let element = UILabel()
        element.textColor = color
        element.font = UIFont.systemFont(ofSize: fontSize, weight: fontwWeight)
        return element
    }
    
    private func toggleCell(_ isSelected: Bool) {
        if isSelected {
            backgroundColor = Colors.pink
            layer.borderWidth = 0
            playImageView.isHidden = false
            votesLabel.textColor = .white
            tagStationLabel.textColor = .white
            nameStationLabel.textColor = .white
            nameStationLabel.textColor = .white
            waveImageView.image = .whiteWave
        } else {
            backgroundColor = .clear
            layer.borderWidth = 2
            playImageView.isHidden = true
            votesLabel.textColor = Colors.anotherGray
            tagStationLabel.textColor = Colors.anotherGray
            nameStationLabel.textColor = Colors.anotherGray
            nameStationLabel.textColor = Colors.anotherGray
            waveImageView.image = .greyWave
        }
        
    }
    
    // MARK: - Actions
    @objc private func didTapLikeButton(_ sender: UIButton) {
        if sender.currentImage == UIImage(resource: .likeFilled).withRenderingMode(.alwaysOriginal) {
            sender.setImage(UIImage(resource: .like).withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            sender.setImage(UIImage(resource: .likeFilled).withRenderingMode(.alwaysOriginal), for: .normal)
//            добавить votes
        }
    }
}

// MARK: - Setup Constraint
private extension PopularCell {
    func setupConstraint() {
        playImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
            make.width.equalTo(25)
            make.height.equalTo(28)
        }
        
        votesLabel.snp.makeConstraints { make in
            make.trailing.equalTo(likeButton.snp.leading).offset(-5)
            make.centerY.equalTo(likeButton.snp.centerY)
        }
        
        likeButton.snp.makeConstraints { make in
            make.width.equalTo(14.66)
            make.height.equalTo(12)
            make.centerY.equalTo(playImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        tagStationLabel.snp.makeConstraints { make in
            make.leading.equalTo(playImageView.snp.leading)
            make.trailing.equalTo(likeButton.snp.trailing)
            make.top.equalTo(playImageView.snp.bottom).offset(5)
        }
        
        nameStationLabel.snp.makeConstraints { make in
            make.top.equalTo(tagStationLabel.snp.bottom).offset(5)
            make.leading.equalTo(playImageView.snp.leading)
            make.trailing.equalTo(likeButton.snp.trailing)
        }
        
        waveImageView.snp.makeConstraints { make in
            make.top.equalTo(nameStationLabel.snp.bottom).offset(10)
            make.height.equalTo(22.66)
            make.centerX.equalToSuperview()
        }
    }
}
