//
//  StationsVC.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 29.07.2024.
//

import UIKit
import SnapKit

class StationsVC: UIViewController {
    
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
    
    private lazy var titleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "playNavigation")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Colors.white
        label.font = Font.getFont(Font.displayBold, size: 24)
//        label.text = K.appName
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton()
        button.sizeToFit()
        button.setImage(UIImage(named: "profileButton"), for: .normal)
        button.addTarget(self, action: #selector(profileDetailTaped), for: .touchUpInside)
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
        slider.minimumValueImage = UIImage(named: "sound")
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var radioCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
    private lazy var bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        //        инициализируем до вызова делегата
        viewModel = RadioStationListVM()
        
                titleLabel.attributedText = LabelFactory.createColorText(for: K.appName)
        
        setView()
        setDelegate()
        setConstraints()
        
        radioCollectionView.register(RadioStationCell.self, forCellWithReuseIdentifier: "RadioStationCell")
        radioCollectionView.reloadData()
    }
    
    // MARK: - Set Views
    
    private func setView() {
        view.backgroundColor = Colors.background
        
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(topStackView)
        
        topStackView.addArrangedSubview(titleImage)
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
    
    // MARK: - Actions

    @objc private func profileDetailTaped() {
        print("Show detail profile info")
    }
}

// MARK: - Extensions Set Constraints

extension StationsVC {
    private func setConstraints() {
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        topStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(68)
        }
        
        titleImage.snp.makeConstraints { make in
            make.size.equalTo(33)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(titleLabel.snp.leading).offset(-5)
        }
        
        profileButton.snp.makeConstraints { make in
            make.width.equalTo(58)
            make.trailing.equalTo(mainStackView).offset(-16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(60)
            make.top.equalTo(topStackView.snp.bottom).offset(20)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(mainStackView).inset(16)
            make.height.equalTo(56)
        }
        
        midleStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        volumeSlider.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(-70)
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

extension StationsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfStations
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RadioStationCell", for: indexPath) as? RadioStationCell else { return UICollectionViewCell() }
        let stationViewModel = viewModel.radioStationViewModel(at: indexPath.row)
        cell.configure(with: stationViewModel)
        return cell
    }
    
    
    
}
