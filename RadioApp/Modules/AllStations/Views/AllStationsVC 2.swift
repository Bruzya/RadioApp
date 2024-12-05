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
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
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
        let textField = UITextField(rightButton)
        return textField
    }()
    
    private let radioTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - Properties
    
    var viewModel = RadioStationListVM()
    
    private var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Search.result.image, for: .normal)
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setDelegate()
        setConstraints()
        
        radioTableView.register(RadioStationCell.self, forCellReuseIdentifier: "RadioStationCell")
        radioTableView.reloadData()
        
        rightButton.addTarget(self, action: #selector(toResultSearch), for: .touchUpInside)
        
        loadAllRadioStation()
        
    }
    
    // MARK: - Set Views
    
    private func setView() {
        view.backgroundColor = Colors.background
        radioTableView.createTable()
        
        view.addSubview(vStack)
        
        vStack.addArrangedSubview(subtitleLabel)
        vStack.addArrangedSubview(searchTextField)
        vStack.addArrangedSubview(radioTableView)
    }
    
    private func setDelegate() {
        radioTableView.delegate = self
        radioTableView.dataSource = self
        searchTextField.delegate = self
    }
    
    func searchRadio() {
        guard let radioName = searchTextField.text, !radioName.isEmpty else {
            viewModel.radioStation.removeAll() // Сбросить старые данные, если поле пустое
            radioTableView.reloadData()
            return
        }

        let filteredStations = viewModel.radioStation.filter { $0.name.lowercased().contains(radioName.lowercased()) }
        if filteredStations.isEmpty {
            viewModel.radioStation.removeAll() // Если ничего не найдено, сбросить данные
        } else {
            viewModel.radioStation = filteredStations
        }
        radioTableView.reloadData()
    }
    
    func loadAllRadioStation() {
        
        viewModel.getStations(Link.allStations.url) { [weak self] in
            DispatchQueue.main.async {
                self?.radioTableView.reloadData()
            }
        }
    }
    
    // MARK: - Selectors
    
    @objc private func profileDetailTaped() {
        print("Show detail profile info")
    }
    
    // Переменная состояния поиска
    private var isSearching: Bool = false
    
    @objc private func toResultSearch() {
        print("Result search radio stations")
        
        if isSearching {
            // Если мы уже находимся в состоянии поиска, то возвращаемся к начальному экрану
            subtitleLabel.isHidden = false
            searchTextField.text = ""
            rightButton.setImage(Search.result.image, for: .normal)
            viewModel.radioStation.removeAll() // Очищаем текущий список
            loadAllRadioStation() // Загружаем все станции
            isSearching = false
        } else {
            // Если мы еще не искали, выполняем поиск
            if let radioName = searchTextField.text, !radioName.isEmpty {
                let filteredStations = viewModel.radioStation.filter { $0.name.lowercased().contains(radioName.lowercased()) }
                
                if filteredStations.isEmpty {
                    // Если ничего не найдено, показываем все станции
                    subtitleLabel.isHidden = false
                    searchTextField.text = ""
                    rightButton.setImage(Search.result.image, for: .normal)
                    viewModel.radioStation.removeAll()
                    loadAllRadioStation()
                } else {
                    // Если есть результаты, переключаемся на результаты поиска
                    subtitleLabel.isHidden = true
                    viewModel.radioStation = filteredStations
                    rightButton.setImage(Search.backToAll.image, for: .normal)
                    radioTableView.reloadData()
                    isSearching = true
                }
            }
        }
        
        // Обновление вида кнопки
        rightButton.setNeedsLayout()
        rightButton.layoutIfNeeded()
    }
    
}

// MARK: - Extensions Set Constraints

extension AllStationsVC {
    private func setConstraints() {
        
        vStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(60)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(56)
        }
        
        radioTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(400)
        }
        
    }
}

// MARK: - TableView DataSource, Delegate

extension AllStationsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfStations
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RadioStationCell", for: indexPath) as? RadioStationCell else {
            return UITableViewCell()
        }
        
        let stationViewModel = viewModel.radioStationViewModel(at: indexPath.row)
        let isSelected = tableView.indexPathsForSelectedRows?.contains(indexPath) ?? false
        cell.configure(with: stationViewModel, isSelected: isSelected)
        
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
            cell.configure(with: viewModel.radioStationViewModel(at: indexPath.row), isSelected: true)
        }
    }
    //    убрали выделение с ячейки в которой играло радио и поставили стоп
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioStationCell {
            cell.configure(with: viewModel.radioStationViewModel(at: indexPath.row), isSelected: false)
        }
    }
}

// MARK: - Extension TextFild Delegate

extension AllStationsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        toResultSearch()
        searchTextField.text = ""
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        searchRadio()
    }
    
}
