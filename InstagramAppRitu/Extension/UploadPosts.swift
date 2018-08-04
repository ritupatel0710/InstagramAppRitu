//
//  UploadPosts.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/3/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import UIKit

extension UploadPostsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
            postImage.image = img
        }
        imagepicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func galleryOrCameraClick(_ sender: UIButton) {
        imagepicker.delegate = self
        imagepicker.sourceType = sender.titleLabel?.text == "Gallery" ? .photoLibrary : .camera
        present(imagepicker,animated: true,completion: nil)
        
    }
}
