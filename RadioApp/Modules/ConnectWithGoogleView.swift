//
//  ConnectWithGoogleView.swift
//  RadioApp
//
//  Created by Алексей on 31.07.2024.
//

import UIKit
import SnapKit

final class ConnectWithGoogleView: UIView {
    
    // MARK: - UI
    private lazy var leftLineView = makeLineView()
    
    private lazy var rightLineView = makeLineView()
    
    private let connectWithLabel = UILabel(type: .connectWith)
    
    private lazy var googleAuthButton: UIButton = {
        let element = UIButton(type: .system)
        element.setBackgroundImage(.google, for: .normal)
        return element
    }()

    
    // MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupViews() {
        addSubview(leftLineView)
        addSubview(rightLineView)
        addSubview(connectWithLabel)
        addSubview(googleAuthButton)
    }
    
    private func makeLineView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(
            red: 141/255,
            green: 146/255,
            blue: 163/255,
            alpha: 1
        )
        return view
    }
}

// MARK: - Setup Constraints
private extension ConnectWithGoogleView {
    func setupConstraints() {
        connectWithLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        leftLineView.snp.makeConstraints { make in
            make.centerY.equalTo(connectWithLabel.snp.centerY)
            make.leading.equalToSuperview()
            make.trailing.equalTo(connectWithLabel.snp.leading).offset(-17)
            make.height.equalTo(1)
        }
        
        rightLineView.snp.makeConstraints { make in
            make.centerY.equalTo(connectWithLabel.snp.centerY)
            make.leading.equalTo(connectWithLabel.snp.trailing).offset(17)
            make.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        googleAuthButton.snp.makeConstraints { make in
            make.top.equalTo(connectWithLabel.snp.bottom).offset(20)
            make.width.height.equalTo(39.89)
            make.centerX.equalToSuperview()
        }
        
        snp.makeConstraints { make in
            make.bottom.equalTo(googleAuthButton.snp.bottom)
        }
    }
}
