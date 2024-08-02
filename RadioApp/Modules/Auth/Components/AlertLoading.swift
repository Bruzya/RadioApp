//
//  Alert.swift
//  RadioApp
//
//  Created by Алексей on 02.08.2024.
//

import UIKit
import SnapKit

final class AlertLoading {
    
    static let shared = AlertLoading()
    
    // MARK: - UI
    private let alert = UIAlertController(
        title: nil,
        message: "Please wait...\n\n\n",
        preferredStyle: .alert
    )
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Init
    private init() {
        alert.view.addSubview(loadingIndicator)
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(10)
        }
    }
    
    // MARK: - Public methods
    func isPresented(_ value: Bool, from viewController: UIViewController) {
        if value {
            loadingIndicator.startAnimating()
            viewController.present(alert, animated: true, completion: nil)
        } else {
            loadingIndicator.stopAnimating()
            viewController.dismiss(animated: true)
        }
    }
}
