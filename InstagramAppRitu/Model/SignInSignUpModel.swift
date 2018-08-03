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
    
    func signUp(fullname: String, email: String, username: String, password: String,completion : @escaping (Error?) -> Void){
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let err = error{
                completion(err)
            }else{
                let dict = ["fullName":fullname,"email":email,"username":username,"password":password]
        
                
                
                self.databaseRef.child("User").child((authResult?.user.uid)!).setValue(dict, withCompletionBlock: { (error, databaseReference) in
                    
                })//updateChildValues(dict)
                //If error is Nil then it should allow to sign-up User and Perform segue to Sign-In(In viewcontroller).
                completion(error)
            }
            print(CurrentUser.sharedInstance.email)
        }
    }
    
    func signIn(email:String, password: String,completion : @escaping (Error?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            let userid = Auth.auth().currentUser?.uid
            if let err = error{
                completion(err)
            }else{
                self.currentUserInstance.email = email
                
                self.databaseRef.child("User").child(userid!).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if let userSnapshot = snapshot.value as? Dictionary<String, Any>{
                        self.currentUserInstance.fullname = userSnapshot["fullName"] as? String
                        self.currentUserInstance.username = userSnapshot["username"] as? String
                        self.currentUserInstance.imageURL = userSnapshot["imageURL"] as? String
                    }
                })
        
                //If error is Nil then it should allow to sign-in User and Perform segue to Home Controller(in ViewController).
                completion(error)
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
            TWMessageBarManager.sharedInstance().showMessage(withTitle: "SUCCESS!", description: "Successfully Password Updated", type: .success, duration: 2.0)
        }
    }
    
    func updateProfile(fullname:String, email:String, username: String){
        
        self.currentUserInstance.email = email
        self.currentUserInstance.fullname = fullname
        self.currentUserInstance.username = username
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        
        changeRequest?.commitChanges { (error) in
            if let err = error{
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "ERROR", description: err.localizedDescription, type: .error, duration: 5.0)
            }else{
                let userid = Auth.auth().currentUser?.uid
                //CurrentUser.sharedInstance.
                let dict = ["fullName":fullname,"email":email,"username":username]
                self.databaseRef.child("User").child(userid!).updateChildValues(dict)
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "SUCCESS!", description: "Successful Update Profile", type: .success, duration: 5.0)
            }
        }
    }
    
    
    func getUserProfile() -> Dictionary<String, String>{
        
        let instance = CurrentUser.sharedInstance
        print(instance.email)
        print(instance.email)
        let dict : Dictionary<String, String> = ["fullname":instance.fullname!,"email":instance.email,"username":instance.username!]
        return dict

    }
    
    func uploadimageintoFirebase(_ img:UIImage, completion : @escaping (URL?)->()){
       
            let userid = Auth.auth().currentUser?.uid
            let data = UIImageJPEGRepresentation(img, 0.5)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            let imagename = "\(userid!).jpeg"
        
            storageRef = storageRef.child("userImages").child(imagename)
            storageRef.putData(data!, metadata: metadata, completion: { (meta, error) in
                
                if error == nil{
                    
                    self.storageRef.downloadURL { (url, error) in
                        
                        self.currentUserInstance.imageURL = url?.absoluteString
                        
                        let dict = ["imageURL": url?.absoluteString]
                        self.databaseRef.child("User").child(userid!).updateChildValues(dict)
                        completion(url)
                    }
                }
            })
        
    }
    
    func getUserProfilePhoto(completion : @escaping (UIImage) -> Void){
        
            let userid = Auth.auth().currentUser?.uid
            let imagename = "\(userid!).jpeg"
            storageRef = storageRef?.child(imagename)
            storageRef?.child("userImages").child("\(userid!).jpeg").getData(maxSize: 1 * 200 * 200, completion: { (data, error) in
                
                if error == nil{
                    let image = UIImage(data: data!)
                    completion(image!)
                }
                else{
                    
                }
            })
    }
    
}
