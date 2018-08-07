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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var signInSignUpModelObj : SignInSignUpModel!
    let imagepicker = UIImagePickerController()
    var postArr = Array<Posts>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.isNavigationBarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        signInSignUpModelObj = SignInSignUpModel()
        getProfilePhoto()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        getCurrentUserPosts()
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
    
    func getCurrentUserPosts(){
        signInSignUpModelObj.getUserPost { (arrPosts) in
            self.postArr = arrPosts
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension UserProfileViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        
        cell.imageView.sd_setImage(with: URL(string: postArr[indexPath.row].imageURL!))
        
        return cell
    }
}

