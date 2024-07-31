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
    }
    
    // MARK: - Actions
    @objc func didTapSignUpButton() {
        print("sign up")
    }
    
    @objc func didTapSignInButton() {
        print("sign in")
    }
}

// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
