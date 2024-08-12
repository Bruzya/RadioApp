//
//  FavoritesVC.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 29.07.2024.
//

import UIKit
import SnapKit
import RealmSwift

final class FavoritesVC: UIViewController {
    
    // MARK: - Private Properties
    private var stations: Results<Station>!
    private var realmService = AppDIContainer().realm
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        label.text = "Favorite"
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    // MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blueDark
        
        stations = realmService.fetchStations()
        
        setupCollectionView()
        addSubviews()
        setupConstraints()
    }
}

// MARK: - Private Methods
private extension FavoritesVC {
    func deleteStation(at indexPath: IndexPath) {
        let station = stations[indexPath.item]
        realmService.delete(station)
        collectionView.deleteItems(at: [indexPath])
    }
    
    func navigateToDetails(with station: Station) {
        //        let detailsVC = StationDetailsVC()
        //        detailsVC.station = station
        //        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            FavoriteViewCell.self,
            forCellWithReuseIdentifier: "FavoriteViewCell"
        )
    }
    
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().inset(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.width.equalToSuperview()
            make.bottom.equalTo(-200)
        }
    }
}

extension FavoritesVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UITableViewDataSource
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return stations.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FavoriteViewCell",
            for: indexPath
        ) as! FavoriteViewCell
        let station = stations[indexPath.item]
        cell.configure(with: station)
        cell.delegate = self
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 100, height: 123)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let selectedStation = stations[indexPath.item]
        navigateToDetails(with: selectedStation)
    }
}

// MARK: - FavoriteViewCellDelegate
extension FavoritesVC: FavoriteViewCellDelegate {
    func didTapFavoriteButton(in cell: FavoriteViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            deleteStation(at: indexPath)
        }
    }
}

