//
//  UpdateUserProfileViewController.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/2/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import UIKit

class UpdateUserProfileViewController: UIViewController {

    var signInSignOutModelObj : SignInSignUpModel!
    
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var bioTV: UITextView!
    @IBOutlet weak var profilePhoto: UIImageView!
    
    var imagepicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bioTV!.layer.borderWidth = 1
        bioTV!.layer.borderColor = UIColor.gray.cgColor
        signInSignOutModelObj = SignInSignUpModel()
        navigationController?.isNavigationBarHidden = true
        editUserData()
    }

    @IBAction func updateClick(_ sender: UIButton) {
        signInSignOutModelObj.updateProfile(fullname:fullname.text!,email:emailTF.text!,bio:bioTV.text ?? "")
        navigationController?.popViewController(animated: true)
    }
    
    func editUserData(){
        signInSignOutModelObj.getUserProfile { (dict) in
            self.setUserProfileData(dict: dict)
        }
    }
    
    func setUserProfileData(dict:Dictionary<String,String>){
        fullname.text = dict["fullname"]
        emailTF.text = dict["email"]
        bioTV.text = dict["bio"]
        if let imgurl = dict["imageURL"]{
            profilePhoto.sd_setImage(with: URL(string: imgurl))
        }
    }
}
