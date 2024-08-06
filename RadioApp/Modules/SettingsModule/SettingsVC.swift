//
//  SettingsVC.swift
//  RadioApp
//
//  Created by dsm 5e on 30.07.2024.
//

import UIKit
import WebKit

final class SettingsVC: UIViewController {
    
    private var settingView: SettingsView!
    
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
