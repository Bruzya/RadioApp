//
//  FirebaseService.swift
//  RadioApp
//
//  Created by dsm 5e on 29.07.2024.
//

import Foundation
import Firebase
import FirebaseStorage
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
    case nameExist = "Name already exist"
    case emailExist = "Email already exist"
    
    static var isPresentedError = false
}

final class FirebaseService {
    
    static let shared = FirebaseService()
        
    var isSessionActive: Bool {
        true
    }
    
    var isAuthorized: Bool {
        if let _ = Auth.auth().currentUser {
            return true
        } else if let _ = GIDSignIn.sharedInstance.currentUser {
            return true
        } else {
            return false
        }
    }
    
    var isAuthorizedWithGoogle = false
    
    // MARK: - Регистрация
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
                    userId: userId,
                    email: userData.email
                )
                self?.signOut()
                completion(.success(true))
            }
        }
    }
    
    // MARK: - Авторизация
    /// Авторизация через почту + пароль
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
    
    /// Авторизация через гугл
    func signInWithGoogle(with controller: UIViewController, completion: @escaping () -> ()) {
        GIDSignIn.sharedInstance.signIn(withPresenting: controller) { [weak self] result, err in
            guard err == nil else {
                return
            }
            
            if let user = result?.user, user.userID != nil {
                if Firestore.firestore().collection("users").document(user.userID!).documentID.isEmpty {
                    self?.setUserData(
                        name: user.profile?.name,
                        userId: user.userID!,
                        email: user.profile!.email
                    )
                }
            }
            self?.isAuthorizedWithGoogle = true
            completion()
        }
    }
    
    // MARK: - Выход из аккаунта
    func signOut(completion: (()->())? = nil) {
        if isAuthorizedWithGoogle {
            GIDSignIn.sharedInstance.signOut()
            isAuthorizedWithGoogle = false
        } else {
            try? Auth.auth().signOut()
        }
        
        completion?()
    }
    
    // MARK: - Сброс пароля
    func resetPassword(email: String, completion: @escaping ()->()) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard error == nil else { return }
            completion()
        }
    }
    
    // MARK: - Обновление пароля
    func updatePassword(_ password: String) {
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            guard error == nil else {
                print("failed to update the password")
                return
            }
        }
    }
    
    // MARK: - Обновление почты
    func updateEmail(_ email: String, completion: @escaping () -> ()) {
        Auth.auth().currentUser?.sendEmailVerification(beforeUpdatingEmail: email, completion: { error in
            guard error == nil else {
                print("failed to update the email")
                return
            }
            completion()
        })
    }
    
    // MARK: - Получение данных юзера
    private func getUserId() -> String? {
        if let userId = Auth.auth().currentUser?.uid {
            return userId
        } else if let userId = GIDSignIn.sharedInstance.currentUser?.userID {
            return userId
        } else {
            return nil
        }
    }
    
    func getCurrentUser(completion: (()->())? = nil) {
        guard let id = getUserId() else { return }
        Firestore.firestore()
            .collection("users")
            .document(id)
            .addSnapshotListener { snap, err in
                guard err == nil else { return }
                if let document = snap {
                    let username = document["name"]
                    let avatarUrl = document["avatarUrl"]
                    let email = document["email"]

                    User.shared.name = username as? String
                    User.shared.avatar = avatarUrl as? String
                    User.shared.email = email as? String
                    
                    completion?()
                }
            }
    }
    
    // MARK: - Загрузка аватара в Firebase
    private func uploadOneImage(image: Data?, storageLink: StorageReference, completion: @escaping (Result<URL, Error>) -> ()) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        guard let image else { return }
        storageLink.putData(image, metadata: metadata) { meta, err in
            guard err == nil else {
                completion(.failure(err!))
                return
            }
            storageLink.downloadURL { url, err in
                guard err == nil else {
                    completion(.failure(err!))
                    return
                }
                
                guard let url else { return }
                completion(.success(url))
            }
        }
    }
    
    func uploadImage(image: Data) {
        guard let userId = getUserId() else { return }
        let imageName = "avatar.jpeg"
        let ref = Storage.storage().reference().child("avatars/" + userId).child(imageName)
        self.uploadOneImage(image: image, storageLink: ref) { [weak self] result in
            switch result {
            case .success(let success):
                self?.setUserAvatar(urlString: success.absoluteString)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    // MARK: - Запись данных в Firebase
    private func setUserAvatar(urlString: String) {
        guard let userId = getUserId() else { return }
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .updateData(["avatarUrl": urlString]) { [weak self] _ in
                self?.getCurrentUser()
            }
    }
    
    func setUserData(name: String?, userId: String, email: String) {
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .setData(["name": name ?? "User", "email": email]) { [weak self] _ in
                self?.getCurrentUser()
            }
    }
    
    func updateUserEmail(_ email: String) {
        guard let userId = getUserId() else { return }
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .updateData(["email": email]) { [weak self] _ in
                self?.getCurrentUser()
            }
    }
    
    func updateUserName(_ name: String) {
        guard let userId = getUserId() else { return }
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .updateData(["name": name]) { [weak self] _ in
                self?.getCurrentUser()
            }
    }
    
    // MARK: - Верификация почты
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
