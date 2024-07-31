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
    }
    
    // MARK: - Actions
    @objc func didTapForgotPassButton() {
        print("forgot password")
    }
    
    @objc func didTapGoogleAuthButton() {
        print("connect with google")
    }
    
    @objc func didTapSignInButton() {
        print("sign in")
    }
    
    @objc func didTapSignUpButton() {
        print("sign up")
    }
}

// MARK: - UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
