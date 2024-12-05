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
    private let auth = FirebaseService.shared
    
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
//        guard sender.currentTitle != "Change password" else {
//            return
//        }
        
        guard let emailText = forgotPassView.emailView.textField.text, !emailText.isEmpty else {
            return
        }
        AlertLoading.shared.isPresented(true, from: self)
        auth.resetPassword(email: emailText) { [weak self] in
            guard let self else { return }
            AlertLoading.shared.isPresented(false, from: self)
            showAlert { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
//        sender.setTitle("Change password", for: .normal)
//        forgotPassView.updateView()
    }
    
    /// Поднимаем активный textfield над клавиатурой
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
private extension ForgotPassViewController {
    /// Alert с просьбой подтвердить сброс пароля по ссылке в письме
    func showAlert(completion: @escaping ()->()) {
        let alert = UIAlertController(
            title: String.localize(key: "alertFine"),
            message: String.localize(key: "forgotDescriptions"),
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default) { [weak self] _ in
                self?.dismiss(animated: true, completion: {
                    completion()
                })
            }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
