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
import SDWebImage

class UserProfileViewController: UIViewController {

    @IBOutlet weak var profilePhoto: UIImageView!
    
    var signInSignUpModelObj : SignInSignUpModel!
    let imagepicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        signInSignUpModelObj = SignInSignUpModel()
        print(CurrentUser.sharedInstance.email)
        print(CurrentUser.sharedInstance.imageURL)
        getProfilePhoto()
    }
    
    @IBAction func settingsClick(_ sender: UIBarButtonItem) {
        
    }
    
    func getProfilePhoto(){
        if let imgURL = CurrentUser.sharedInstance.imageURL{
            profilePhoto.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "launch"))
        }
    }
    
    func uploadPhoto(img:UIImage){
        
    }
}

