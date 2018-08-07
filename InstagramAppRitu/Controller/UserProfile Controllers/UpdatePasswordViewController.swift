//
//  UpdatePasswordViewController.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/2/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import UIKit

class UpdatePasswordViewController: UIViewController {

    @IBOutlet weak var updatePasswordTF: UITextField!
    var signinSignUpModelObj : SignInSignUpModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signinSignUpModelObj = SignInSignUpModel()
    }

    @IBAction func updatePassword(_ sender: UIButton) {
        signinSignUpModelObj.updatePassword(pwd: updatePasswordTF.text!)
    }
}
