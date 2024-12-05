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
    private let auth = FirebaseService.shared
    
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
    /// Регистрация пользователя
    @objc func didTapSignUpButton() {
        let name = signUpView.nameView.textField.text
        
        guard let email = signUpView.emailView.textField.text, !email.isEmpty else {
            showErrorView(.enterEmail)
            return
        }
        
        guard let password = signUpView.passwordView.textField.text, !password.isEmpty else {
            showErrorView(.enterPassword)
            return
        }
        
        AlertLoading.shared.isPresented(true, from: self)
        
        auth.signUp(
            userData: UserRegData(
                name: name,
                email: email,
                password: password
            )) { [weak self] result in
                guard let self else { return }
                
                AlertLoading.shared.isPresented(false, from: self)
                
                switch result {
                case .success:
                    showAlert()
                case .failure(let failure):
                    switch failure {
                    case .incorrectEmail:
                        showErrorView(.incorrectEmail)
                    case .incorrectPassword:
                        showErrorView(.incorrectPassword)
                    default:
                        break
                    }
                }
            }
    }
    
    /// Возврат на экран Sign In
    @objc func didTapSignInButton() {
        dismiss(animated: true)
    }
    
    /// Поднимаем активный textfield над клавиатурой
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
private extension SignUpViewController {
    /// Alert с просьбой подтвердить свою почту по ссылке
    func showAlert() {
        let alert = UIAlertController(
            title: String.localize(key: "alertFine"),
            message: String.localize(key: "alertDescription"),
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default) { [weak self] _ in
                self?.dismiss(animated: true)
            }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
