//
//  RenameVC.swift
//  RadioApp
//
//  Created by Drolllted on 05.08.2024.
//

import UIKit

final class RenameVC: UIViewController {
    
    var completionHandler: ((UIImage?, String?, String?) -> ())?
    var avatar: UIImage?
    
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
        if let imageData = renameView.avatarImage.image?.jpegData(compressionQuality: 0.1) {
            auth.uploadImage(image: imageData)
        }
        completionHandler?(renameView.avatarImage.image, renameView.nameLabel.text, renameView.emailLabel.text)
        navigationController?.popViewController(animated: true)
    }
    
}
