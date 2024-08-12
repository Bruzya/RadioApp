//
//  LanguageVC.swift
//  RadioApp
//
//  Created by Drolllted on 12.08.2024.
//

import UIKit

final class LanguageVC: UIViewController {
    
    private var languageView: LanguageView!
    
    override func loadView() {
        languageView = LanguageView()
        view = languageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = String.localize(key: "rename")
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : Font.getFont(.displayBold, size: 18),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left")?.withTintColor(.white, renderingMode: .alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(goBackToSettings)
        )
    }
    
    @objc func goBackToSettings() {
        navigationController?.popViewController(animated: true)
    }
    
}
