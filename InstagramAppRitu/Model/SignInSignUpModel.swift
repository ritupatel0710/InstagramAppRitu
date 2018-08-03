//
//  SignInSignUpModel.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/2/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import Foundation
import FirebaseDatabase
import TWMessageBarManager
import FirebaseAuth
import UIKit
import FirebaseStorage

class SignInSignUpModel{
    
    var databaseRef: DatabaseReference!
    var currentUserInstance = CurrentUser.sharedInstance
    var storageRef : StorageReference!
    init(){
       
        databaseRef = Database.database().reference()
        storageRef = Storage.storage().reference()
    }
    
    func signUp(fullname: String, email: String, username: String, password: String,completion : @escaping (Error) -> Void){
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if error != nil{
                completion(error!)
            }else{
                let dict = ["fullName":fullname,"email":email,"username":username,"password":password]
                
                self.currentUserInstance.email = email
                self.currentUserInstance.fullname = fullname
                self.currentUserInstance.password = password
                self.currentUserInstance.username = username
                
                self.databaseRef.child("User").child((authResult?.user.uid)!).updateChildValues(dict)
                if let err = error{
                    completion(err)
                }
            }
            print(CurrentUser.sharedInstance.email)
        }
    }
    
    func signIn(email:String, password: String,completion : @escaping (Error) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil{
                completion(error!)
                
            }else{
                if let err = error{
                    completion(err)
                }
            }
        }
    }
    
    
    func resetPassword(email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let err = error{
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "ERROR", description: err.localizedDescription, type: .error, duration: 5.0)
                
            }else{
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "SUCCESS!", description: "Successfully Password Reset", type: .success, duration: 5.0)
            }
        }
    }

    
    func signOut(){
        do{
            
            currentUserInstance.email = nil
            currentUserInstance.fullname = nil
            currentUserInstance.username = nil
            currentUserInstance.password = nil
            try Auth.auth().signOut()
            
        }catch{
            
        }
    }
    
    func updatePassword(pwd: String){
        Auth.auth().currentUser?.updatePassword(to: pwd) { (error) in
            TWMessageBarManager.sharedInstance().showMessage(withTitle: "SUCCESS!", description: "Successfully Password Updated", type: .success, duration: 5.0)
        }
    }
    
    func updateProfile(fullname:String, email:String, username: String, password: String){
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        
        changeRequest?.commitChanges { (error) in
            if let err = error{
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "ERROR", description: err.localizedDescription, type: .error, duration: 5.0)
            }else{
                let userid = Auth.auth().currentUser?.uid
                //CurrentUser.sharedInstance.
                let dict = ["fullName":fullname,"email":email,"username":username,"password":password]
                self.databaseRef.child("User").child(userid!).updateChildValues(dict)
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "SUCCESS!", description: "Successful Update Profile", type: .success, duration: 5.0)
            }
        }
    }
//    self.currentUserInstance.email = email
//    self.currentUserInstance.fullname = fullname
//    self.currentUserInstance.username = username
//    self.currentUserInstance.password = password
    
    func getUserProfile() -> Dictionary<String, String>{
        let instance = CurrentUser.sharedInstance
        print(instance.email)
        let dict : Dictionary<String, String> = ["fullname":instance.fullname!,"email":instance.email,"username":instance.username!,"password":instance.password!]
        return dict
//        databaseRef.child("User").observeSingleEvent(of: .value) { (snapshot) in
//            guard let values = snapshot.value as? [String: Any] else{
//                return
//            }
//            for item in values{
//                if let dict = item.value as? Dictionary<String, Any>{
//                    print(dict)
//                }
//            }
//        }
    }
    
    func uploadimageintoFirebase(img:UIImage){
       
            let userid = Auth.auth().currentUser?.uid
            print(userid)
            // get image
        
            let data = UIImageJPEGRepresentation(img, 0.5)
            //save img to nornaml data
            //nrml data to metadata
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            //metadata.path == "userImages/\(userid!).jpeg"
            let imagename = "\(userid!).jpeg"
        
            storageRef = storageRef.child("userImages").child(imagename)
            storageRef.putData(data!, metadata: metadata, completion: { (meta, error) in
                if error == nil{
                    print(meta)
                }
            })
    }
    
    func getUserProfilePhoto(completion : @escaping (UIImage) -> Void){
        
            let userid = Auth.auth().currentUser?.uid
//            let imagename = "\(userid!).jpeg"
//            storageRef = storageRef?.child(imagename)
            storageRef?.child("userImages").child("\(userid!).jpeg").getData(maxSize: 1 * 2000 * 2000, completion: { (data, error) in
                
                if error == nil{
                    let image = UIImage(data: data!)
                    print(image)
                    completion(image!)
                }
                else{
                    
                }
            })
    }
    
}
