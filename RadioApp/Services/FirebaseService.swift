//
//  FirebaseService.swift
//  RadioApp
//
//  Created by dsm 5e on 29.07.2024.
//

import Foundation
import Firebase
import GoogleSignIn

struct UserRegData {
    let name: String?
    let email: String
    let password: String
}

struct AuthUserData {
    let email: String
    let password: String
}

enum UserVerification {
    case verified, noVerified
}

enum AuthError: String, Error {
    case enterEmail = "Enter your email"
    case enterPassword = "Enter your password"
    case incorrectEmail = "Check your email is spelled correctly"
    case incorrectPassword = "Password must be 6 characters or more"
    case incorrectEmailOrLogin = "Incorrect email and/or password"
    
    static var isPresentedError = false
}

final class FirebaseService {
    
    static let shared = FirebaseService()
    
    var isSessionActive: Bool {
        true
    }
    
    var isAuthorized: Bool {
        if let _ = Auth.auth().currentUser?.isEmailVerified {
            return true
        } else {
            return false
        }
    }
    
    func signUp(userData: UserRegData, completion: @escaping (Result<Bool, AuthError>) ->()) {
        Auth.auth().createUser(
            withEmail: userData.email,
            password: userData.password
        ) { [weak self] result, error in
            guard error == nil else {
                if let validEmail = self?.isValidEmail(userData.email), !validEmail {
                    completion(.failure(.incorrectEmail))
                } else if userData.password.count < 6 {
                    completion(.failure(.incorrectPassword))
                }
                return
            }
            
            result?.user.sendEmailVerification { error in
                guard error == nil else {
                    return
                }
            }
            
            if let userId = result?.user.uid {
                self?.setUserData(
                    name: userData.name,
                    userId: userId
                )
                self?.signOut()
                completion(.success(true))
            }
        }
    }
    
    func setUserData(name: String?, userId: String) {
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .setData(["name": name ?? ""])
    }
            
    func signIn(userData: AuthUserData, completion: @escaping (Result<UserVerification, AuthError>) -> ()) {
        Auth.auth().signIn(withEmail: userData.email, password: userData.password) { result, err in
            guard err == nil else {
                completion(.failure(.incorrectEmailOrLogin))
                return
            }
            
            if let verify = result?.user.isEmailVerified, verify {
                completion(.success(.verified))
            } else {
                completion(.success(.noVerified))
            }
        }
    }
    
    func signInWithGoogle(with controller: UIViewController, completion: @escaping () -> ()) {
        GIDSignIn.sharedInstance.signIn(withPresenting: controller) { [weak self] result, err in
            guard err == nil else {
                return
            }
            
            if let user = result?.user, user.userID != nil {
                self?.setUserData(
                    name: user.profile?.name,
                    userId: user.userID!
                )
            }
            
            completion()
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
    }
    
    func resetPassword() {}
    
    func getCurrentUser() -> String? {
        if let userId = Auth.auth().currentUser?.uid {
            return userId
        } else if let userId = GIDSignIn.sharedInstance.currentUser?.userID {
            return userId
        } else {
            return nil
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
