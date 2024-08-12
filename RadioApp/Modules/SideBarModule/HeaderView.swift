//
//  HeaderView.swift
//  RadioApp
//
//  Created by dsm 5e on 06.08.2024.
//

import UIKit
import SnapKit

final class HeaderView: UIView {
    
    private let auth = FirebaseService.shared
    
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
        label.textColor = Colors.pink
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 27.5
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        auth.getCurrentUser { [weak self] in
            guard let self else { return }
            titleLabel.attributedText = LabelFactory.createColorText(for: User.shared.nameForHeader)
            if let _ = User.shared.avatarUrl {
                profileImage.getImage(from: User.shared.avatarUrl)
            } else {
                profileImage.image = UIImage(systemName: "person.circle")
            }
        }
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
