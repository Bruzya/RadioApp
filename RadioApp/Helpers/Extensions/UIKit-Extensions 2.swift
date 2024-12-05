//
//  UIKit-Extensions.swift
//  RadioApp
//
//  Created by Alexander Bokhulenkov on 08.08.2024.
//

import UIKit

extension UITextField {
    convenience init(_ rightButton: UIButton) {
        self.init()
        self.backgroundColor = Colors.grey
        self.leftView = Search.iconPadding
        self.leftViewMode = .always
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightButton.frame = CGRect(x: -60, y: -25, width: 120, height: 120)
        rightView.addSubview(rightButton)
        self.rightView = rightView
        self.rightViewMode = .always
        
        self.textColor = Colors.white
        self.attributedPlaceholder = NSAttributedString(
            string: K.placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.white]
        )
        self.returnKeyType = .search
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UITableView {
    func createTable() {
        self.separatorStyle = .none
        self.estimatedRowHeight = 50
        self.rowHeight = UITableView.automaticDimension
        self.isScrollEnabled = true
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
