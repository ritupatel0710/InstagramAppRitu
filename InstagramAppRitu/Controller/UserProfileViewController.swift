//
//  UserProfileViewController.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/2/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class UserProfileViewController: UIViewController {

    @IBOutlet weak var profilePhoto: UIImageView!
    
    var signInSignUpModelObj : SignInSignUpModel!
    
    let imagepicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInSignUpModelObj = SignInSignUpModel()
        navigationController?.isNavigationBarHidden = true
        getProfilePhoto()
    }
    
    @IBAction func settingsClick(_ sender: UIBarButtonItem) {
        
    }
    func getProfilePhoto(){
        signInSignUpModelObj.getUserProfilePhoto { (img) in
            self.profilePhoto.image = img
        }
    }
    
    
}

extension UserProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    
    
    @IBAction func imgButtonClick(_ sender: UIButton) {
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
            signInSignUpModelObj.uploadimageintoFirebase(img:profilePhoto.image!)
        }
        imagepicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        imagepicker.dismiss(animated: true, completion: nil)
    }
}
