//
//  AllStationsVC.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 29.07.2024.
//

import UIKit
import SnapKit

class AllStationsVC: UIViewController {
    
    // MARK: - UI properties
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var topStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Colors.white
        label.font = Font.getFont(Font.displayBold, size: 24)
        label.text = K.appName
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "profileAvatar"), for: .normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.getFont(Font.displayMedium, size: 20)
        label.textColor = Colors.white
        label.text = K.screenName
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Colors.grey
        textField.textColor = Colors.white
        textField.attributedPlaceholder = NSAttributedString(
            string: K.placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.white]
        )
        textField.layer.cornerRadius = 20
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var midleStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var volumeSlider: UISlider = {
        let slider = UISlider()
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        slider.thumbTintColor = Colors.teal
        slider.minimumTrackTintColor = Colors.teal
        slider.maximumTrackTintColor = Colors.grey
        slider.tintColor = Colors.grey
//        ОРИЕНТАЦИЯ !!!!!!
        slider.minimumValueImage = UIImage(systemName: "speaker.wave.2")
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var radioCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collection.backgroundColor = .yellow
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var emptiView: UIView = {
       let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Properties
    
    var viewModel: RadioStationListVM!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraints()
        setDelegate()
        
        radioCollectionView.reloadData()
    }
    
    // MARK: - Set Views
    
    private func setView() {
        view.backgroundColor = Colors.background
        
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(topStackView)
        
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(profileButton)
        
        mainStackView.addArrangedSubview(subtitleLabel)
        mainStackView.addArrangedSubview(searchTextField)
        mainStackView.addArrangedSubview(midleStackView)
        
        midleStackView.addArrangedSubview(volumeSlider)
        midleStackView.addArrangedSubview(radioCollectionView)
        
        mainStackView.addArrangedSubview(emptiView)
    }
    
    private func setDelegate() {
        radioCollectionView.delegate = self
        radioCollectionView.dataSource = self
    }

}

// MARK: - Extensions Set Constraints

extension AllStationsVC {
    private func setConstraints() {
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        topStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topStackView)
            make.leading.equalTo(topStackView).offset(22)
        }
        
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(topStackView)
            make.trailing.equalTo(topStackView.snp.trailing).offset(-17)
            make.width.equalTo(51)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(60)
            make.top.equalTo(topStackView.snp.bottom).offset(20)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(17)
            make.height.equalTo(56)
        }
        
        midleStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        volumeSlider.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(29)
            make.width.equalTo(200)
        }
        
        radioCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.width.equalTo(300)
            
            make.height.equalTo(300)
        }
    }
}

// MARK: - Extensions Collection View

extension AllStationsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RadioStationCell", for: indexPath) as? RadioStationCell else { return UICollectionViewCell() }
        let stationViewModel = viewModel.radioStationViewModel(at: indexPath.row)
        cell.configure(with: stationViewModel)
        return cell
    }
    
    
    
}
