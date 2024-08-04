//
//  FavoriteViewCell.swift
//  RadioApp
//
//  Created by Vladimir Dmitriev on 04.08.24.
//

import UIKit

final class FavoriteViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    private let randomColor: UIColor = {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }()
    
    private let favoriteView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    private let tagsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "POP"
        label.textColor = .white
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Radio Record"
        label.textColor = .white
        return label
    }()
    
    private let waveImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "wave")
        return image
    }()
    
    private let leadingCircleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let trailingCircleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let waveContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        
        let image = UIImage(named: "likeFilled")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        
        button.tintColor = .blueLight
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 15
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubview()
        setupView()
        setupLayout()
        
        favoriteButton.addTarget(
            self,
            action: #selector(favoriteButtonTapped),
            for: .touchUpInside
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
//    func configure(with station: Station) {
//        tagsLabel.text = station.tags
//        nameLabel.text = station.name
//    }
}

// MARK: - Private Methods
private extension FavoriteViewCell {
    @objc func favoriteButtonTapped() {
        
    }
    
    func setupWaveContainerView() {
        leadingCircleView.backgroundColor = randomColor
        trailingCircleView.backgroundColor = randomColor
        
        waveContainerView.addSubview(waveImage)
        waveContainerView.addSubview(leadingCircleView)
        waveContainerView.addSubview(trailingCircleView)
    }
    
    func setupTextStackView() {
        textStackView.addArrangedSubview(tagsLabel)
        textStackView.addArrangedSubview(nameLabel)
        textStackView.addArrangedSubview(waveContainerView)
    }
    
    func setupContentStackView() {
        contentStackView.addArrangedSubview(textStackView)
        contentStackView.addArrangedSubview(favoriteButton)
    }
    
    func setupSubview() {
        setupWaveContainerView()
        setupTextStackView()
        setupContentStackView()
    }
    
    func setupView() {
        addSubview(favoriteView)
        favoriteView.addSubview(contentStackView)
    }
    
    func setupLayout() {
        favoriteView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints { make in
            make.center.equalTo(favoriteView)
            make.leading.equalTo(favoriteView).inset(20)
            make.top.equalTo(favoriteView).inset(20)
        }
        
        waveContainerView.snp.makeConstraints { make in
            make.height.equalTo(waveImage)
        }
        
        waveImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        leadingCircleView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 8, height: 8))
            make.leading.equalToSuperview()
            make.centerY.equalTo(waveImage.snp.top).offset(10)
        }
        
        trailingCircleView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 8, height: 8))
            make.trailing.equalToSuperview()
            make.centerY.equalTo(waveImage.snp.top).offset(10)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.width.equalTo(favoriteButton.snp.height)
            make.height.equalTo(contentStackView.snp.height).multipliedBy(0.7)
        }
    }
}

