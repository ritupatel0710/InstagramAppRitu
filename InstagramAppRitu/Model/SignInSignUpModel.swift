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
    
    func signUp(fullname: String, email: String,password: String,completion : @escaping (Error?) -> Void){
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let err = error{
                completion(err)
            }else{
                let dict = ["fullName":fullname,"email":email,"password":password]
                self.databaseRef.child("User").child((authResult?.user.uid)!).setValue(dict, withCompletionBlock: { (error, databaseReference) in
                })
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
                        self.currentUserInstance.userId = userid
                        self.currentUserInstance.fullname = userSnapshot["fullName"] as? String
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
    
    func updateProfile(fullname:String, email:String){
        
        self.currentUserInstance.email = email
        self.currentUserInstance.fullname = fullname
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        
        changeRequest?.commitChanges { (error) in
            if let err = error{
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "ERROR", description: err.localizedDescription, type: .error, duration: 5.0)
            }else{
                let userid = Auth.auth().currentUser?.uid
                //CurrentUser.sharedInstance.
                let dict = ["fullName":fullname,"email":email]
                self.databaseRef.child("User").child(userid!).updateChildValues(dict)
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "SUCCESS!", description: "Successful Update Profile", type: .success, duration: 5.0)
            }
        }
    }
    
    
    func getUserProfile() -> Dictionary<String, String>{
        
        let instance = CurrentUser.sharedInstance
        print(instance.email)
        print(instance.email)
        let dict : Dictionary<String, String> = ["fullname":instance.fullname!,"email":instance.email]
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
    
    func uploadPost(_ img:UIImage, caption: String){//,competion : @escaping (Error?)->()
        
        let key = databaseRef.child("Posts").childByAutoId().key //PostId
        let userid = Auth.auth().currentUser?.uid
        let timestamp = Date().timeIntervalSince1970
        
        let dict : Dictionary<String,Any> = ["userId":userid,"postDescription":caption,"timestamp":timestamp]
        
        self.databaseRef.child("Posts").child(key).setValue(dict, withCompletionBlock: { (error, databaseReference) in
            self.saveimageintoStorage(img,key)
            self.setpostidInUserTable(key)
        })
        
        
    }
    
    func saveimageintoStorage(_ img: UIImage, _ key: String){
        
        let data = UIImageJPEGRepresentation(img, 0.5)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let imagename = "\(key).jpeg"
        
        storageRef.child("postImages").child(imagename).putData(data!, metadata: metadata, completion: { (meta, error) in
            if error == nil{
                self.storageRef.child("postImages").child(imagename).downloadURL { (url, error) in
                    let dict = ["imageURL": url?.absoluteString]
                    self.databaseRef.child("Posts").child(key).updateChildValues(dict)
                }
            }
        })
        
    }
    
    func setpostidInUserTable(_ postId : String){
        let userId = Auth.auth().currentUser?.uid
        let dict = [postId:"postId"]
        databaseRef.child("User").child(userId!).child("posts").updateChildValues(dict)
    }
    
    func getUserPost(competion: @escaping (Array<Posts>) -> () ){
        
        let userId = Auth.auth().currentUser?.uid
        
        databaseRef.child("User").child(userId!).child("posts").observeSingleEvent(of: .value) { (snapShot) in
            
            for childSnap in  snapShot.children.allObjects {
                
                let snap = childSnap as! DataSnapshot
                let postidKey = snap.key
                var postArray = Array<Posts>()
            
                        self.databaseRef.child("Posts").child(postidKey).observeSingleEvent(of: .value, with: { (snapshot) in
                
                            if let postSnapshot = snapshot.value as? Dictionary<String, Any>{

                                let post = Posts(postidKey,postSnapshot["userId"] as! String,postSnapshot["postDescription"] as! String,postSnapshot["timestamp"] as! Double,postSnapshot["imageURL"] as! String, nil)
                                
                                postArray.append(post)
                            }
                            competion(postArray)
                        })
            }
        }
    }
    
    func getAllUsersPosts(completion: @escaping (Array<Posts>)->()) {
        
        databaseRef.child("Posts").observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? Dictionary<String,Any> else {
                completion([])
                return
            }
            var postArr : Array<Posts> = []
            
            for item in value {
                
                if let post = item.value as? Dictionary<String,Any> {
                
                    self.getUser(userID: post["userId"] as! String, completion: { (user) in
                    
                        let objPost = Posts(item.key, post["userId"] as! String,post["postDescription"] as! String,post["timestamp"] as! Double, post["imageURL"] as! String, user)
                        
                        postArr.append(objPost)
                        
                        postArr.sort(by: {Double($0.timestamp!) > Double($1.timestamp!)})
                        
                        completion(postArr)
                    })
                }
            }
        }
    }
    
    func getUser(userID: String, completion:@escaping (User)->()){
        
        self.databaseRef.child("User").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let userSnapshot = snapshot.value as? Dictionary<String, Any>{
                
                if let imageurl = userSnapshot["imageURL"]{
                    
                    let user = User(userId: userID, email: userSnapshot["email"]! as! String, fullname: userSnapshot["fullName"]! as! String, password: userSnapshot["password"]! as! String, imageURL: userSnapshot["imageURL"]! as! String, postId: nil)
                    completion(user)
                }
            }
        })
    }
    
    func getAllUserList(completion :@escaping (Array<User?>) -> ()){
        
        let userid = Auth.auth().currentUser?.uid
        var arrUser = Array<User>()
        
        self.databaseRef.child("User").observeSingleEvent(of: .value) { (snapshot) in
            
            if let snapUser = snapshot.value as? Dictionary<String,Any>{
                
                for item in snapUser{
                    
                    self.getUsersExceptFriends(completion: { (arrFrnds) in
                    print(!(arrFrnds?.contains(item.key))!)
                    //print(arrFrnds)
                        if item.key != userid && !(arrFrnds?.contains(item.key))!{//
                        
                        if let eachUser = item.value as? Dictionary<String,Any>{
                            
                            if let imgurl = eachUser["imageURL"]{
                                
                                let userObj = User(userId: item.key, email: eachUser["email"]! as! String, fullname: eachUser["fullName"]! as! String, password: nil, imageURL: imgurl as? String, postId: nil)
                                        arrUser.append(userObj)
                                        //print(arrUser)
                                        
                            }
                            else{
                                let userObj = User(userId: item.key, email: eachUser["email"]! as! String, fullname: eachUser["fullName"]! as! String, password: nil, imageURL: nil, postId: nil)
                                arrUser.append(userObj)
                                
                            }
                            completion(arrUser)
                            }
                        }
                        })
                    
                }
            }
        }
    }
    func getUsersExceptFriends(completion : @escaping (Array<String>?)->()){
            
        let userid = Auth.auth().currentUser?.uid
        var arrNotBeingDisplayedFrnd = Array<String>()
        self.databaseRef.child("User").child(userid!).observeSingleEvent(of: .value) { (snapshot) in
            
        //print(snapshot)
        if let snap = snapshot.value as? Dictionary<String,Any>{
            if let snapFriend = snap["friends"] as? Dictionary<String,Any>{
               for i in snapFriend{
                    //print(i.key)
                    arrNotBeingDisplayedFrnd.append(i.key)
               }
                print(arrNotBeingDisplayedFrnd)
            }
            completion(arrNotBeingDisplayedFrnd)
        }else{
            completion(nil)
        }
            
    }
}
    
    func addUserAsFriend(_ addUserAsFriend: String){
        let userid = Auth.auth().currentUser?.uid
        let dict = [addUserAsFriend : "friendId"]
        databaseRef.child("User").child(userid!).child("friends").updateChildValues(dict)
    }
    
    func getMyAllFriends(completion :@escaping (Array<User?>) ->()){
        
        let userId = Auth.auth().currentUser?.uid
        
        databaseRef.child("User").child(userId!).child("friends").observeSingleEvent(of: .value) { (snapshot) in
            
            var arrFriend = Array<User>()
            
            if let userSnapshot = snapshot.value as? Dictionary<String,Any>{
                for item in userSnapshot{
                    //item.key is friendId
                    self.databaseRef.child("User").child(item.key).observeSingleEvent(of: .value, with: { (snapshot) in
                        if let friendSnapshot = snapshot.value as? Dictionary<String,Any>{
                            var user : User!
                            if let img = friendSnapshot["imageURL"]{
                                user = User(userId: item.key, email: friendSnapshot["email"]! as! String, fullname: friendSnapshot["fullName"]! as! String, password: nil, imageURL: friendSnapshot["imageURL"]! as! String, postId: nil)
                            }else{
                                user = User(userId: item.key, email: friendSnapshot["email"]! as! String, fullname: friendSnapshot["fullName"]! as! String, password: nil, imageURL: nil, postId: nil)
                            }
                            arrFriend.append(user)
                            completion(arrFriend)
                            
                        }
                    })
                }
            }
        }
    }
}

