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
        addNotifications()
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
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let keyboardHeight = keyboardFrame.height
        var contentInset = forgotPassView.scrollView.contentInset
        contentInset.bottom = keyboardHeight + 50
        forgotPassView.scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        forgotPassView.scrollView.contentInset = .zero
    }
}

// MARK: - UITextFieldDelegate
extension ForgotPassViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

// MARK: - Notifications
extension ForgotPassViewController {
    func addNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}
