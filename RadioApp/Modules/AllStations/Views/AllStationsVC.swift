//
//  AllStationsVC.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 29.07.2024.
//

import UIKit
import SnapKit

final class AllStationsVC: UIViewController {
    
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
        let textField = UITextField(rightButtonImage: Search.result.image, target: self, action: #selector(toResultSearch))
        return textField
    }()
    
    private let radioTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - Properties
    
    var viewModel = RadioStationListVM()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setDelegate()
        setConstraints()
        
        radioTableView.register(RadioStationCell.self, forCellReuseIdentifier: "RadioStationCell")
        radioTableView.reloadData()
        
        viewModel.getStations(Link.allStations.url) { [weak self] in
            DispatchQueue.main.async {
                self?.radioTableView.reloadData()
            }
        }
        
    }
    
    // MARK: - Set Views
    
    private func setView() {
        view.backgroundColor = Colors.background
        radioTableView.createTable()
        
        view.addSubview(subtitleLabel)
        view.addSubview(searchTextField)
        
        view.addSubview(radioTableView)
    }
    
    private func setDelegate() {
        radioTableView.delegate = self
        radioTableView.dataSource = self
        searchTextField.delegate = self
    }
    
    func searchRadio() {
        if let radioName = searchTextField.text, !radioName.isEmpty {
            let filteredStations = viewModel.radioStation.filter { $0.name.lowercased().contains(radioName.lowercased()) }
            print(filteredStations)
            // После фильтрации надо будет передать на др экран
            viewModel.radioStation = filteredStations
            radioTableView.reloadData()
        }
    }
    
    // MARK: - Selectors
    
    @objc private func profileDetailTaped() {
        print("Show detail profile info")
    }
    
    @objc private func toResultSearch() {
        print("Result search radio stations")
        searchRadio()
        navigationController?.pushViewController(SearchVC(), animated: true)
    }
}

// MARK: - Extensions Set Constraints

extension AllStationsVC {
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
        
        radioTableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.centerX.equalTo(view)
            make.height.equalTo(400)
            make.width.equalTo(293)
        }
        
    }
}

// MARK: - TableView DataSource, Delegate

extension AllStationsVC: UITableViewDelegate, UITableViewDataSource {
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

// MARK: - Extension TextFild Delegate

extension AllStationsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        searchRadio()
    }
}
