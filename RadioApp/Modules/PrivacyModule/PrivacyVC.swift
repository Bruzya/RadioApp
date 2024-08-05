//
//  PrivacyVC.swift
//  RadioApp
//
//  Created by Drolllted on 05.08.2024.
//

import UIKit

final class PrivacyVC: UIViewController{
    
    private var privacyView: PrivacyView!
    
    override func loadView() {
        privacyView = PrivacyView()
        view = privacyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Privacy"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : Font.getFont(.displayMedium, size: 16), NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(goBackToSettings))
    }
    
    @objc func goBackToSettings() {
        navigationController?.popViewController(animated: true)
    }
    
}
