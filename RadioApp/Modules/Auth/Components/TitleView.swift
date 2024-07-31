//
//  TitleView.swift
//  RadioApp
//
//  Created by Алексей on 31.07.2024.
//

import UIKit
import SnapKit

final class TitleView: UIView {
    
    // MARK: - Private properties
    private let isSignTitle: Bool
    
    // MARK: - UI
    private lazy var titleLabel = UILabel(type: isSignTitle ? .titleSign : .titleForgotPass)
    
    // MARK: - Init
    init(frame: CGRect, isSignTitle: Bool) {
        self.isSignTitle = isSignTitle
        
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private methods
    private func setupViews() {
        addSubview(titleLabel)
    }
    
}

// MARK: - Setup Constraints
private extension TitleView {
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        
        snp.makeConstraints { make in
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.bottom.equalTo(titleLabel.snp.bottom)
        }
    }
}
