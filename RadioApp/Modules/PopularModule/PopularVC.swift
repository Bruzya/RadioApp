//
//  PopularsVC.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 29.07.2024.
//

import UIKit

final class PopularVC: UIViewController {
    
    // MARK: - UI
    private let popularView = PopularView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = popularView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        popularView.setDelegates(self)
    }
    
    deinit {
        print("Deinit \(type(of: self))")
    }
    
}

// MARK: - UICollectionViewDataSource
extension PopularVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.description(), for: indexPath) as? PopularCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PopularVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 15.0
        let numberOfItemsPerRow: CGFloat = 2
        let totalSpacing = (numberOfItemsPerRow - 1) * interItemSpacing
        let itemSize = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: itemSize, height: itemSize)
    }
}
