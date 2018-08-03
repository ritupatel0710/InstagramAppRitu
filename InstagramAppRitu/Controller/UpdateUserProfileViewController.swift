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
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInSignOutModelObj = SignInSignUpModel()
        editUserData()
    }

    @IBAction func updateClick(_ sender: UIButton) {
        signInSignOutModelObj.updateProfile(fullname:fullname.text!,email:emailTF.text!,username:usernameTF.text!,password:passwordTF.text!)
        navigationController?.popViewController(animated: true)
    }
    
    func editUserData(){
        let dict = signInSignOutModelObj.getUserProfile()
        setUserProfileData(dict: dict)
    }
    
    func setUserProfileData(dict:Dictionary<String,String>){
        fullname.text = dict["fullname"]
        emailTF.text = dict["email"]
        usernameTF.text = dict["username"]
        passwordTF.text = dict["password"]
    }
}
