//
//  UpdateProfile.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/7/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import UIKit

extension UpdateUserProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBAction func changePhotoClick(_ sender: Any) {
        imagepicker.delegate = self
        if imagepicker.sourceType == .camera{
            imagepicker.sourceType = .camera
        }else{
            imagepicker.sourceType = .photoLibrary
        }
        present(imagepicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
            profilePhoto.image = img
            signInSignOutModelObj.uploadimageintoFirebase(img) { (url) in
                
                self.profilePhoto.sd_setImage(with: url, placeholderImage: UIImage(named: "userProfilePhoto"))
            }
        }
        imagepicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        imagepicker.dismiss(animated: true, completion: nil)
    }
}
