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
    
    var onSignIn: (() -> Void)?
    
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
    }
    
    private func clearTextField() {
        signInView.emailView.textField.text = nil
        signInView.passwordView.textField.text = nil
    }
    
    // MARK: - Actions
    /// Переход на экран Forgot Password
    @objc func didTapForgotPassButton() {
        let vc = ForgotPassViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// Авторизация через Google
    @objc func didTapGoogleAuthButton() {
        auth.signInWithGoogle(with: self) { [weak self] in
            guard let self else { return }
            clearTextField()
            onSignIn?()
        }
    }
    
    /// Авторизация через email + password
    @objc func didTapSignInButton() {
        guard let email = signInView.emailView.textField.text, !email.isEmpty else {
            showErrorView(.enterEmail)
            return
        }
        
        guard let password = signInView.passwordView.textField.text, !password.isEmpty else {
            showErrorView(.enterPassword)
            return
        }
        
        AlertLoading.shared.isPresented(true, from: self)
        
        auth.signIn(
            userData: AuthUserData(email: email, password: password)) { [weak self] result in
                guard let self else { return }
                
                AlertLoading.shared.isPresented(false, from: self)
                
                switch result {
                case .success(let success):
                    switch success {
                    case .verified:
                        auth.updateUserEmail(email)
                        clearTextField()
                        onSignIn?()
                    case .noVerified:
                        showAlert()
                    }
                case .failure:
                    showErrorView(.incorrectEmailOrLogin)
                }
            }
    }
    
    /// Переход на экран Sign Up
    @objc func didTapSignUpButton() {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    /// Поднимаем активный textfield над клавиатурой
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
    /// Добавляем нотификации показа/скрытия клавиатуры
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

// MARK: - Alert
private extension SignInViewController {
    /// Alert предупреждает что почта не подтверждена
    func showAlert() {
        let alert = UIAlertController(
            title: String.localize(key: "alertHeader"),
            message: String.localize(key: "alertDescription"),
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default
        )
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

