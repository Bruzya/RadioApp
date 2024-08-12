//
//  StationDetailsVC.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 29.07.2024.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import AVFoundation

final class StationDetailsVC: UIViewController {

    var onDismiss = PublishRelay<Void>()

    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(.back, for: .normal)
        return button
    }()

    private let frequencyBarsView = FrequencyBarsView()

    private let favoritesButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        return button
    }()

    let radioLabel: UILabel = {
        let label = UILabel()
        label.text = "90.5"
        label.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    let stationLabel: UILabel = {
        let label = UILabel()
        label.text = "Radio Divelement"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(resource: .background)
        return imageView
    }()

    var audioPlayer: AVPlayer?

    private var isFavorite = false

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startAudioProcessing()
        setupBindings()
    }

    override func viewDidDisappear(_ animated: Bool) {
        onDismiss.accept(())
    }

    private func setupBindings() {
        backButton.rx.tap
            .mapToVoid()
            .bind(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: false)
            })
            .disposed(by: disposeBag)

        favoritesButton.rx.tap
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.isFavorite.toggle()
                let imageName: ImageResource = self.isFavorite ? .likeFilled : .like
                self.favoritesButton.setImage(UIImage(resource: imageName).withRenderingMode(.alwaysTemplate), for: .normal)
                self.favoritesButton.tintColor = self.isFavorite ? .red : .white
            })
            .disposed(by: disposeBag)
    }

    private func startAudioProcessing() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self, audioPlayer?.rate != 0 else { return }
            let magnitudes = AudioProcessor.sharedInstance.frequencyMagnitudes
            DispatchQueue.main.async {
                self.frequencyBarsView.updateBars(with: magnitudes)
            }
        }
    }
}

private extension StationDetailsVC {
    func setupUI() {
        favoritesButton.setImage(UIImage(resource: isFavorite ? .likeFilled : .like).withRenderingMode(.alwaysTemplate), for: .normal)
        favoritesButton.tintColor = isFavorite ? .red : .white
        view.backgroundColor = Colors.background
        navigationController?.navigationBar.isHidden = true
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(backButton)
        view.addSubview(favoritesButton)
        view.addSubview(frequencyBarsView)
        view.addSubview(radioLabel)
        view.addSubview(stationLabel)
    }

    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(30)
        }

        favoritesButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(30)
        }

        radioLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        stationLabel.snp.makeConstraints { make in
            make.top.equalTo(radioLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        frequencyBarsView.snp.makeConstraints { make in
            make.top.equalTo(stationLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
    }
}
