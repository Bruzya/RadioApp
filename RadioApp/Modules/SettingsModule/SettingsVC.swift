//
//  SettingsVC.swift
//  RadioApp
//
//  Created by dsm 5e on 30.07.2024.
//

import WebKit
import UIKit
import RxSwift
import RxCocoa

import UIKit
import RxSwift
import RxCocoa

final class SettingsVC: UIViewController {

    private var settingView: SettingsView!
    private let disposeBag = DisposeBag()

    override func loadView() {
        settingView = SettingsView()
        view = settingView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "SettingsVC"

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : Font.getFont(.displayBold, size: 16), NSAttributedString.Key.foregroundColor : UIColor.white]

        settingView.buttonLegal.addTarget(self, action: #selector(goToPrivacyVC), for: .touchUpInside)
        settingView.renameButton.addTarget(self, action: #selector(goToRenameVC), for: .touchUpInside)
        settingView.buttonAbout.addTarget(self, action: #selector(goToAboutVC), for: .touchUpInside)
        setupBindings()
    }

    @objc func goToPrivacyVC(){
        let vc = PrivacyVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func goToRenameVC() {
        let vc = RenameVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func goToAboutVC() {
        let vc = WebViewController()
        vc.urlString = "https://dino.zone/ru/"
        guard let url = URL(string: vc.urlString) else {fatalError("Problems with URL")}

        navigationController?.present(vc, animated: true)
    }
}

extension SettingsVC {
    func setupBindings() {
        settingView.switchNotification.rx
            .isOn
            .bind(onNext: { [unowned self] isOn in
                if isOn {
                    requestNotificationAuthorization()
                } else {
                    // Хз че делать когда отключаем нотификации
                }
            })
            .disposed(by: disposeBag)
    }

    private func requestNotificationAuthorization() {
        UserNotificationService.shared.requestAuthorization { [weak self] granted, error in
            if granted {
                self?.showTimePickerVC()
            } else if let error = error {
                self?.showAuthorizationErrorAlert(error: error)
            } else {
                self?.showNotificationDisabledAlert()
            }
        }
    }
    
    // MARK: - Показываем пикер
    private func showTimePickerVC() {
        DispatchQueue.main.async {
            let timePickerVC = TimePickerVC()
            self.navigationController?.present(timePickerVC, animated: true)
        }
    }

    // MARK: - Алерт когда возникла ошибка при разрешении доступа
    private func showAuthorizationErrorAlert(error: Error) {
        print("Ошибка при запросе разрешения на уведомления: \(error.localizedDescription)")
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ошибка", message: "Не удалось получить разрешение на уведомления", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Алерт когда уведомления отключены и переходим в настройки
    private func showNotificationDisabledAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Уведомления отключены", message: "Пожалуйста, включите уведомления в настройках приложения", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Настройки", style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            })
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
