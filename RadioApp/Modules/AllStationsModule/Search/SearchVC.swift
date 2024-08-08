//
//  SearchVC.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 29.07.2024.
//

import UIKit
import SnapKit

final class SearchVC: UIViewController {
    
    // MARK: - UI Properties
    
    private lazy var resultTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Colors.grey
        textField.leftView = Search.iconPadding
        textField.leftViewMode = .always
    
//        let rightButton = UIButton(type: .custom)
//        rightButton.setImage(Search.backToAll.image, for: .normal)
//        rightButton.addTarget(self, action: #selector(toAllStation), for: .touchUpInside)
//        
//        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        rightButton.frame = CGRect(x: -60, y: -25, width: 120, height: 120)
//        rightView.addSubview(rightButton)
//        textField.rightView = rightView
//        textField.rightViewMode = .always
        
        textField.textColor = Colors.white
        textField.attributedPlaceholder = NSAttributedString(
            string: K.placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.white]
        )
        textField.returnKeyType = .search
        textField.layer.cornerRadius = 20
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        navigationItem.hidesBackButton = true
        
        setView()
        setConstraints()
    }
    
    
    // MARK: - Set Views
    
    private func setView() {
        view.addSubview(resultTextField)
    }
    // MARK: - Selectors
    
    @objc private func toAllStation() {
        print("return back to all stations")
    }
    
}

// MARK: - Extensions Set Constraints

extension SearchVC {
    private func setConstraints() {
        
        resultTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.equalTo(view).inset(10)
            make.height.equalTo(56)
        }
    }
}
