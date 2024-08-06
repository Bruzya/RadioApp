//
//  ImagePicker.swift
//  RadioApp
//
//  Created by Drolllted on 05.08.2024.
//

import UIKit


class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var renameView: RenameView?
    
    func showImagePicker(for viewController: UIViewController ,sourseType: UIImagePickerController.SourceType, renameView: RenameView){
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        imagePickerVC.allowsEditing = true
        imagePickerVC.sourceType = sourseType
       
        viewController.present(imagePickerVC, animated: true)
        self.renameView = renameView
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickerImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            renameView?.avatarImage.image = pickerImage
        }
        picker.dismiss(animated: true)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}

