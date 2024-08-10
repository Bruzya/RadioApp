//
//  PopularView.swift
//  RadioApp
//
//  Created by Алексей on 09.08.2024.
//

import UIKit
import SnapKit

final class PopularView: UIView {
    
    // MARK: - UI
    lazy var title: UILabel = {
        let element = UILabel()
        element.text = "Popular"
        element.textColor = .white
        element.font = UIFont.systemFont(ofSize: 30, weight: .light)
        return element
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 14
        layout.minimumInteritemSpacing = 15
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.description())
        collection.backgroundColor = .clear
        collection.delaysContentTouches = false
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    lazy var spinner = createSpinner(style: .large)
    lazy var spinnerPagination = createSpinner(style: .medium)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
        addSubview(collectionView)
        addSubview(spinnerPagination)
        collectionView.addSubview(spinner)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public methods
    func setDelegates(_ controller: PopularVC) {
        collectionView.dataSource = controller
        collectionView.delegate = controller
    }
    
    // MARK: - Private methods
    private func createSpinner(style: UIActivityIndicatorView.Style) -> UIActivityIndicatorView {
        let element = UIActivityIndicatorView(style: style)
        element.hidesWhenStopped = true
        element.color = .white
        return element
    }
}

// MARK: - Setup Constraints
private extension PopularView {
    func setupConstraints() {
        title.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(28)
            make.leading.equalToSuperview().offset(66.1)
        }
        
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(60.5)
            make.trailing.equalToSuperview().offset(-60.5)
            make.bottom.equalTo(spinnerPagination.snp.top)
        }
        
        spinnerPagination.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-140)
        }
    }
}
