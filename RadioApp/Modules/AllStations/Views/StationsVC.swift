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
    
    private lazy var radioTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    private lazy var bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var backwardsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "previous"), for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(backwardsButtonTaped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "player"), for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(playButtonTaped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "next"), for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(forwardButtonTaped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var emptiView: UIView = {
        let view = UIView()
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
        
        radioTableView.register(RadioStationCell.self, forCellReuseIdentifier: "RadioStationCell")
        radioTableView.reloadData()
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
        midleStackView.addArrangedSubview(radioTableView)
        
        mainStackView.addArrangedSubview(bottomStack)
        
        bottomStack.addArrangedSubview(backwardsButton)
        bottomStack.addArrangedSubview(playButton)
        bottomStack.addArrangedSubview(forwardButton)
        
        mainStackView.addArrangedSubview(emptiView)
    }
    
    private func setDelegate() {
        radioTableView.delegate = self
        radioTableView.dataSource = self
    }
    
    // MARK: - Actions
    
    @objc private func profileDetailTaped() {
        print("Show detail profile info")
    }
    
    @objc private func backwardsButtonTaped() {
        print("Play backwards")
    }
    
    @objc private func playButtonTaped() {
        print("Play sound")
    }
    
    @objc private func forwardButtonTaped() {
        print("Play forward")
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
        
        radioTableView.snp.makeConstraints { make in
            make.leading.equalTo(volumeSlider.snp.trailing).offset(-60)
            make.height.equalTo(400)
        }
        
        bottomStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(75)
        }
    }
}

// MARK: - Extensions Collection View

extension StationsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfStations
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RadioStationCell", for: indexPath) as? RadioStationCell else { return UITableViewCell() }
        let stationViewModel = viewModel.radioStationViewModel(at: indexPath.row)
        cell.configure(with: stationViewModel)
        cell.selectionStyle = .none
        cell.layer.borderColor = Colors.grey.cgColor
        cell.layer.borderWidth = 2.0
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        if selectedCell?.backgroundColor != Colors.pink {
            selectedCell?.backgroundColor = Colors.pink
        } else {
            selectedCell?.backgroundColor = .clear
        }
    }
}
