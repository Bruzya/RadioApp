//
//  HeaderView.swift
//  RadioApp
//
//  Created by dsm 5e on 06.08.2024.
//

import UIKit

final class HeaderView: UIView {
    
    // MARK: - UI properties
    
    private lazy var topStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Colors.white
        label.font = Font.getFont(Font.displayBold, size: 24)
        return label
    }()
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileButton")
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        addSubview(topStackView)
        titleLabel.attributedText = LabelFactory.createColorText(for: K.appName)
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(profileImage)
        setConstraints()
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make
                .height
                .equalTo(36)
        }
        
        profileImage.snp.makeConstraints { make in
            make
                .size
                .equalTo(55)
        }
        
        topStackView.snp.makeConstraints { make in
            make
                .edges
                .equalToSuperview()
        }
    }
}
