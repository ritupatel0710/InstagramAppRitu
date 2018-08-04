//
//  UploadPostsViewController.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/3/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import UIKit

class UploadPostsViewController: UIViewController {

    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    
    var imagepicker : UIImagePickerController!
    
    var signinSignOutModelObj : SignInSignUpModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        imagepicker = UIImagePickerController()
        signinSignOutModelObj = SignInSignUpModel()
    }
    
    @IBAction func doneClick(_ sender: UIButton) {
        signinSignOutModelObj.uploadPost(postImage.image!, caption: textView.text!)
    }
    
}


