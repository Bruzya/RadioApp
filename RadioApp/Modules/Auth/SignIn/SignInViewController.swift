//
//  SignInViewController.swift
//  RadioApp
//
//  Created by Алексей on 30.07.2024.
//

import UIKit

final class SignInViewController: UIViewController {
    
    // MARK: - Private properties
    private let signInView = SignInView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = signInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInView.setDelegates(controller: self)
        signInView.setTargetForButton(controller: self)
        addTapGestureToHideKeyboard()
        addNotifications()
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Actions
    @objc func didTapForgotPassButton() {
        print("forgot password")
        let vc = ForgotPassViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapGoogleAuthButton() {
        print("connect with google")
    }
    
    @objc func didTapSignInButton() {
        print("sign in")
    }
    
    @objc func didTapSignUpButton() {
        print("sign up")
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let keyboardHeight = keyboardFrame.height
        var contentInset = signInView.scrollView.contentInset
        contentInset.bottom = keyboardHeight + 50
        signInView.scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        signInView.scrollView.contentInset = .zero
    }
}

// MARK: - UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

// MARK: - Notifications
extension SignInViewController {
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
