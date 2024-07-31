//
//  SugnUpViewController.swift
//  RadioApp
//
//  Created by Алексей on 31.07.2024.
//

import UIKit
import SnapKit

final class SignUpViewController: UIViewController {
    
    // MARK: - Private properties
    private let signUpView = SignUpView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        signUpView.setDelegates(controller: self)
        signUpView.setTargetForButton(controller: self)
        addNotifications()
    }
    
    // MARK: - Actions
    @objc func didTapSignUpButton() {
        print("sign up")
    }
    
    @objc func didTapSignInButton() {
        print("sign in")
        dismiss(animated: true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let keyboardHeight = keyboardFrame.height
        var contentInset = signUpView.scrollView.contentInset
        contentInset.bottom = keyboardHeight + 50
        signUpView.scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        signUpView.scrollView.contentInset = .zero
    }
}

// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

// MARK: - Notifications
extension SignUpViewController {
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
