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
    
    let volumeView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.font = Font.getFont(Font.displayRegular, size: 12)
        label.textColor = Colors.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true

        return label
    }()
    
    private lazy var volumeSlider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        slider.thumbTintColor = Colors.teal
        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
        slider.minimumTrackTintColor = Colors.teal
        slider.maximumTrackTintColor = Colors.grey
        slider.tintColor = Colors.grey
        slider.addTarget(self, action: #selector(updateVolumeLabel), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.isHidden = true
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
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Properties
    
    var viewModel: RadioStationListVM!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        инициализируем до вызова делегата
        viewModel = RadioStationListVM()
        setView()
        setDelegate()
        setConstraints()
        
        radioTableView.register(RadioStationCell.self, forCellReuseIdentifier: "RadioStationCell")
        radioTableView.reloadData()
        
        volumeSlider.value = 10
        volumeLabel.text = String(format: "%.0f", volumeSlider.value) + "%"
        
    }
    
    // MARK: - Set Views
    
    private func setView() {
        view.backgroundColor = Colors.background
        view.addSubview(subtitleLabel)
        view.addSubview(searchTextField)
        view.addSubview(volumeView)
        
        volumeView.addSubview(volumeLabel)
        volumeView.addSubview(volumeSlider)
        volumeView.addSubview(volumeImage)
        
        view.addSubview(radioTableView)
    }
    
    private func setDelegate() {
        radioTableView.delegate = self
        radioTableView.dataSource = self
    }
    
    // MARK: - Selectors
    
    @objc private func profileDetailTaped() {
        print("Show detail profile info")
    }
    
    @objc private func updateVolumeLabel() {
        volumeLabel.text = "\(Int(volumeSlider.value))%"
    }
}

// MARK: - Extensions Set Constraints

extension StationsVC {
    private func setConstraints() {
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(60)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(6)
            make.leading.trailing.equalTo(view).inset(10)
            make.height.equalTo(56)
        }
        
        volumeView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(60)
            make.trailing.equalTo(radioTableView.snp.leading).offset(-10)
            make.width.equalTo(30)
            make.height.equalTo(300)
        }
        
        volumeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(volumeView)
            make.bottom.equalTo(volumeView.snp.top).offset(40)
        }
        
        volumeSlider.snp.makeConstraints { make in
            make.center.equalTo(volumeView)
            make.width.equalTo(200)
        }
        
        volumeImage.snp.makeConstraints { make in
            make.centerX.equalTo(volumeView)
            make.top.equalTo(volumeSlider.snp.bottom).offset(105)
        }
        
        radioTableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.centerX.equalTo(view)
            make.height.equalTo(400)
            make.width.equalTo(293)
        }
        
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
        cell.clipsToBounds = false
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

//    выбор ячейки в которой играет радио
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioStationCell {
            cell.selectCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioStationCell {
            cell.deselectCell()
        }
    }
}
