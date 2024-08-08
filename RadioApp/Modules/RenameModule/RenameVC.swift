//
//  RenameVC.swift
//  RadioApp
//
//  Created by Drolllted on 05.08.2024.
//

import UIKit

final class RenameVC: UIViewController {
    
    var completionHandlerAvatar: ((UIImage?) -> ())?
    var completionHandlerName: ((String?) -> ())?
    var completionHandlerEmail: ((String?) -> ())?
    var avatar: UIImage?
    var name: String?
    var email: String?
    
    private var renameView: RenameView!
    private let imagePicker = ImagePicker()
    private let auth = FirebaseService.shared
    
    override func loadView() {
        renameView = RenameView()
        view = renameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renameView.avatarImage.image = avatar ?? UIImage(systemName: "person.circle")
        renameView.nameLabel.text = name
        renameView.emailLabel.text = email
        renameView.textFieldName.placeholder = name
        renameView.textFieldEmail.placeholder = email
        navigationItem.title = "Rename"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : Font.getFont(.displayBold, size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left")?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(goBackToSettings))
        
        renameView.reinstallImageButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        renameView.saveButton.addTarget(self, action: #selector(saveInfo), for: .touchUpInside)
    }
    
    @objc func goBackToSettings() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addImage() {
        let alertController = UIAlertController(title: "Add Image?", message: "How do you want to add a picture?", preferredStyle: .actionSheet)
        
        let alertAddWithGallery = UIAlertAction(title: "Gallery", style: .default) { alert in
            self.imagePicker.showImagePicker(for: self, sourseType: .photoLibrary, renameView: self.renameView)
        }
        let alertAddWithPhotoes = UIAlertAction(title: "Photo", style: .default) { alert in
            self.imagePicker.showImagePicker(for: self, sourseType: .camera, renameView: self.renameView)

        }
        let canselButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(alertAddWithGallery)
        alertController.addAction(alertAddWithPhotoes)
        alertController.addAction(canselButton)
        
        present(alertController, animated: true)
        
    }
    
    @objc func saveInfo() {
        updateUserData { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
}

// MARK: - Update User Data
private extension RenameVC {
    func updateUserData(completionHandler: @escaping () -> ()) {
        guard renameView.textFieldName.text?.lowercased() != User.shared.name?.lowercased() else {
            showErrorView(.nameExist)
            return
        }
        
        if let imageData = renameView.avatarImage.image?.jpegData(compressionQuality: 0.1) {
            auth.uploadImage(image: imageData)
        }
        completionHandlerAvatar?(renameView.avatarImage.image)
        
        if let name = renameView.textFieldName.text, !name.isEmpty {
            auth.updateUserName(name)
            completionHandlerName?(renameView.textFieldName.text)
        }
        
        guard renameView.textFieldEmail.text?.lowercased() != User.shared.email?.lowercased() else {
            showErrorView(.emailExist)
            return
        }
        if let email = renameView.textFieldEmail.text, !email.isEmpty {
            guard auth.isValidEmail(email) else {
                showErrorView(.incorrectEmail)
                return
            }
            completionHandlerEmail?(renameView.textFieldEmail.text)
            AlertLoading.shared.isPresented(true, from: self)
            auth.updateEmail(email) { [weak self] in
                guard let self else { return }
                AlertLoading.shared.isPresented(false, from: self)
                showAlert() {
                    completionHandler()
                }
            }
        } else {
            completionHandler()
        }
    }
}

// MARK: - Alert
private extension RenameVC {
    /// Alert с просьбой подтвердить свою почту по ссылке
    func showAlert(completion: @escaping ()->()) {
        let alert = UIAlertController(
            title: "Fine 😊",
            message: "Follow the link we emailed you to confirm your new email address",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default) { [weak self] _ in
                self?.dismiss(animated: true)
                completion()
            }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
