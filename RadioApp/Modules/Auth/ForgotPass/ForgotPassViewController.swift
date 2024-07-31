//
//  ForgotPassViewController.swift
//  RadioApp
//
//  Created by Алексей on 31.07.2024.
//

import UIKit
import SnapKit

final class ForgotPassViewController: UIViewController {
    
    // MARK: - Private properties
    private let forgotPassView = ForgotPassView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = forgotPassView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        forgotPassView.setDelegates(controller: self)
        forgotPassView.setTargetForButton(controller: self)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Actions
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapSentButton(_ sender: UIButton) {
        guard sender.currentTitle != "Change password" else {
            return
        }
        sender.setTitle("Change password", for: .normal)
        forgotPassView.updateView()
        print(sender.currentTitle ?? "")
    }
}

// MARK: - UITextFieldDelegate
extension ForgotPassViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
