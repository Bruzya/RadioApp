//
//  PopularCell.swift
//  RadioApp
//
//  Created by Алексей on 09.08.2024.
//

import UIKit
import SnapKit

final class PopularCell: UICollectionViewCell {
    
    private let networkService = NetworkService.shared
    private var stationId: String?
    private var votes: Int?
    var handlerShowAlert: (()->())?
    
    // MARK: - UI
    private lazy var tagStationLabel = createLabel(fontSize: 25, fontwWeight: .bold)
    lazy var nameStationLabel = createLabel(fontSize: 15, fontwWeight: .regular)
    private lazy var votesLabel = createLabel(fontSize: 10, fontwWeight: .bold)
    
    private lazy var playImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.image = .play
        element.alpha = 0
        return element
    }()
    
    private lazy var likeButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(resource: .like).withRenderingMode(.alwaysOriginal), for: .normal)
        element.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        return element
    }()
    
    private lazy var waveImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.image = .greyWave
        return element
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupViews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Overridess methods
    override var isSelected: Bool {
        didSet {
            toggleCell(isSelected)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playImageView.alpha = 0
    }
    
    // MARK: - Public methods
    func configureCell(_ station: Station) {
        tagStationLabel.text = station.tags.isEmpty ? "..." : station.tags.split(separator: ",").first?.capitalized
        nameStationLabel.text = clearWhitespaceAndTabs(station.name).isEmpty ? "..." : clearWhitespaceAndTabs(station.name)
        votesLabel.text = "votes\n\(station.votes.description)"
        if let vote = Int(station.votes.description) {
            votes = vote
        }
        stationId = station.stationuuid
    }
    
    // MARK: - Private methods
    private func setupViews() {
        [
            playImageView,
            tagStationLabel,
            nameStationLabel,
            votesLabel,
            likeButton,
            waveImageView
        ].forEach {
            addSubview($0)
        }
        
        votesLabel.textAlignment = .right
        votesLabel.numberOfLines = 2
        tagStationLabel.textAlignment = .center
        nameStationLabel.textAlignment = .center
        nameStationLabel.numberOfLines = 2
        votesLabel.adjustsFontSizeToFitWidth = true
        tagStationLabel.adjustsFontSizeToFitWidth = true
        nameStationLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setupCell() {
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = Colors.anotherGray.cgColor
        backgroundColor = Colors.background
    }
    
    private func createLabel(
        color: UIColor = Colors.anotherGray,
        fontSize: CGFloat,
        fontwWeight: UIFont.Weight
    ) -> UILabel {
        let element = UILabel()
        element.textColor = color
        element.font = UIFont.systemFont(ofSize: fontSize, weight: fontwWeight)
        return element
    }
    
    private func toggleCell(_ isSelected: Bool) {
        if isSelected {
            UIView.animate(withDuration: 0.25) { [unowned self] in
                backgroundColor = Colors.pink
                layer.borderWidth = 0
                playImageView.alpha = 1
                votesLabel.textColor = .white
                tagStationLabel.textColor = .white
                nameStationLabel.textColor = .white
                nameStationLabel.textColor = .white
                waveImageView.image = .whiteWave
            }
        } else {
            UIView.animate(withDuration: 0.25) { [unowned self] in
                backgroundColor = .clear
                layer.borderWidth = 2
                playImageView.alpha = 0
                votesLabel.textColor = Colors.anotherGray
                tagStationLabel.textColor = Colors.anotherGray
                nameStationLabel.textColor = Colors.anotherGray
                nameStationLabel.textColor = Colors.anotherGray
                waveImageView.image = .greyWave
            }
        }
    }
    
    private func clearWhitespaceAndTabs(_ string: String) -> String {
        let characterSet = CharacterSet.whitespacesAndNewlines
        let trimmedString = string.trimmingCharacters(in: characterSet)
        
        guard let firstLetterIndex = trimmedString.firstIndex(where: { $0.isLetter }) else {
            return ""
        }
        
        return String(trimmedString[firstLetterIndex...])
    }
    
    private func fetchVotes(completion: @escaping (Bool)->()) {
        guard let stationId else { return }
        networkService.voteForStation(from: Link.vote.url, with: stationId) { result in
            switch result {
            case .success(let success):
                success.ok ? completion(true) : completion(false)
            case .failure(let failure):
                print(failure.localizedDescription)
                completion(false)
            }
        }
    }
    
    // MARK: - Actions
    @objc private func didTapLikeButton(_ sender: UIButton) {
        fetchVotes { [weak self] result in
            guard let self else { return }
            if result {
                guard votes != nil else { return }
                votes! += 1
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    votesLabel.text = "votes\n\(votes!.description)"
                    sender.setImage(UIImage(resource: .likeFilled).withRenderingMode(.alwaysOriginal), for: .normal)
                }
            } else {
                handlerShowAlert?()
            }
        }
    }
}

// MARK: - Setup Constraint
private extension PopularCell {
    func setupConstraint() {
        playImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
            make.width.equalTo(25)
            make.height.equalTo(28)
        }
        
        votesLabel.snp.makeConstraints { make in
            make.leading.equalTo(playImageView.snp.trailing).offset(10)
            make.trailing.equalTo(likeButton.snp.leading).offset(-5)
            make.centerY.equalTo(likeButton.snp.centerY)
        }
        
        likeButton.snp.makeConstraints { make in
            make.width.equalTo(14.66)
            make.height.equalTo(12)
            make.centerY.equalTo(playImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        tagStationLabel.snp.makeConstraints { make in
            make.leading.equalTo(playImageView.snp.leading)
            make.trailing.equalTo(likeButton.snp.trailing)
            make.top.equalTo(playImageView.snp.bottom)
        }
        
        nameStationLabel.snp.makeConstraints { make in
            make.top.equalTo(tagStationLabel.snp.bottom)
            make.leading.equalTo(playImageView.snp.leading)
            make.trailing.equalTo(likeButton.snp.trailing)
            make.bottom.equalTo(waveImageView.snp.top).offset(-5)
        }
        
        waveImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(22.66)
            make.centerX.equalToSuperview()
        }
    }
}



