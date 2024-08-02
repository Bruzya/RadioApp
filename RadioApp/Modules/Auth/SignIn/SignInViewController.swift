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
    private let auth = FirebaseService.shared
    
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
        let vc = ForgotPassViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapGoogleAuthButton() {
    }
    
    @objc func didTapSignInButton() {
        guard let email = signInView.emailView.textField.text, !email.isEmpty else {
            print("введите email")
            return
        }
        
        guard let password = signInView.passwordView.textField.text, !password.isEmpty else {
            print("введите password")
            return
        }
        
        auth.signIn(
            userData: AuthUserData(email: email, password: password)) { result in
                switch result {
                case .success(let success):
                    switch success {
                    case .verified:
                        print("получилось! 😋") // Авторизация пройдена, переходим на главный экран
                    case .noVerified:
                        print("подтвердите email по ссылке в почте 😋")
                    }
                case .failure:
                    print("неправильный логин и/или пароль ☹️")
                }
            }
    }
    
    @objc func didTapSignUpButton() {
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
