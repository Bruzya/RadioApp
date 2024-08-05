//
//  RenameVC.swift
//  RadioApp
//
//  Created by Drolllted on 05.08.2024.
//

import UIKit

final class RenameVC: UIViewController {
    
    private var renameView: RenameView!
    
    override func loadView() {
        renameView = RenameView()
        view = renameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Rename"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : Font.getFont(.displayMedium, size: 16), NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(goBackToSettings))
    }
    
    @objc func goBackToSettings() {
        navigationController?.popViewController(animated: true)
    }
    
}
