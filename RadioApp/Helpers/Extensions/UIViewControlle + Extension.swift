//
//  UIViewControlle + Extension.swift
//  RadioApp
//
//  Created by Алексей on 31.07.2024.
//

import UIKit
import SnapKit

extension UIViewController {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showErrorView(_ error: AuthError) {
        let colouredTopBlack = UIView()
        colouredTopBlack.backgroundColor = .systemRed
        
        let label = UILabel()
        colouredTopBlack.addSubview(label)
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = error.rawValue
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first(where: {$0.isKeyWindow}) {
                colouredTopBlack.frame = CGRect(
                    x: 0,
                    y: -93,
                    width: window.frame.width,
                    height: 93
                )
                window.addSubview(colouredTopBlack)
            }
        }
        
        label.snp.makeConstraints { make in
            make.bottom.equalTo(colouredTopBlack.snp.bottom).offset(-16)
            make.centerX.equalTo(colouredTopBlack.snp.centerX)
        }
        
        if !AuthError.isPresentedError {
            AuthError.isPresentedError = true
            UIView.animate(withDuration: 0.25) {
                colouredTopBlack.frame = colouredTopBlack.frame.offsetBy(dx: 0, dy: 93)
            } completion: { _ in
                UIView.animate(withDuration: 0.25, delay: 1.5) {
                    colouredTopBlack.frame = colouredTopBlack.frame.offsetBy(dx: 0, dy: -93)
                } completion: { _ in
                    colouredTopBlack.removeFromSuperview()
                    AuthError.isPresentedError = false
                }
            }
        }
    }
}
