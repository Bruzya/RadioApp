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
        textField.leftView = Search.icon
        textField.leftViewMode = .always
        textField.leftView = Search.iconPadding
        textField.rightView = Search.result
        textField.rightViewMode = .always
        textField.rightView = Search.resultPadding
        textField.textColor = Colors.white
        textField.attributedPlaceholder = NSAttributedString(
            string: K.placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.white]
        )
        textField.returnKeyType = .search
        textField.layer.cornerRadius = 20
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let volumeStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.clipsToBounds = false
        stack.backgroundColor = .brown
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    
    private lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.font = Font.getFont(Font.displayRegular, size: 12)
        label.textColor = Colors.white
        label.text = "61%"
//        label.text = String(format: "%.0f", volumeSlider.value) + "%"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var volumeSlider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        slider.backgroundColor = .red
        slider.thumbTintColor = Colors.teal
        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
        slider.minimumTrackTintColor = Colors.teal
        slider.maximumTrackTintColor = Colors.grey
        slider.tintColor = Colors.grey
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var volumeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sound")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        
        view.addSubview(topStackView)
        
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(profileButton)
        
        view.addSubview(subtitleLabel)
        view.addSubview(searchTextField)
        view.addSubview(volumeStackView)
        
        volumeStackView.addArrangedSubview(volumeLabel)
        volumeStackView.addArrangedSubview(volumeSlider)
        volumeStackView.addArrangedSubview(volumeImage)
        
        view.addSubview(radioTableView)
        
        bottomStack.addArrangedSubview(backwardsButton)
        bottomStack.addArrangedSubview(playButton)
        bottomStack.addArrangedSubview(forwardButton)
    }
    
    private func setDelegate() {
        radioTableView.delegate = self
        radioTableView.dataSource = self
    }
    
    // MARK: - Selectors
    
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
        
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(80)
            make.leading.equalTo(view).offset(62)
            make.trailing.equalTo(view).offset(-8)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom)
            make.leading.equalToSuperview().offset(60)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(6)
            make.leading.trailing.equalTo(view).inset(10)
            make.height.equalTo(56)
        }
        
        volumeStackView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(80)
            make.leading.equalTo(view).offset(80)
            make.width.equalTo(30)
            
            
        }
        
        volumeSlider.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(300)
        }
        
        volumeImage.snp.makeConstraints { make in
            make.height.equalTo(10)
        }
        
//        radioTableView.snp.makeConstraints { make in
//            make.leading.equalTo(volumeSlider.snp.trailing).offset(-60)
//            make.height.equalTo(400)
//        }
        
    }
}

// MARK: - TableView DataSource, Delegate

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
