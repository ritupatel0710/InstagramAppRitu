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

class SignInSignUpModel{
    
    var databaseRef: DatabaseReference!
    
    init(){
        databaseRef = Database.database().reference()
    }
    
    func signUp(fullname: String, email: String, username: String, password: String){
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let err = error{
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "ERROR", description: err.localizedDescription, type: .error, duration: 5.0)
                
            }else{
                let dict = ["fullName":fullname,"email":email,"username":username,"password":password]
                self.databaseRef.child("User").child((authResult?.user.uid)!).updateChildValues(dict)
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "SUCCESS!", description: "Successful Sign Up", type: .success, duration: 5.0)
            }
        }
    }
    
    func signIn(email:String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let err = error{
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "ERROR", description: err.localizedDescription, type: .error, duration: 5.0)
                
            }else{
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "SUCCESS!", description: "Signed In", type: .success, duration: 5.0)
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
            try Auth.auth().signOut()
        }catch{
            
        }
    }
    
    func updatePassword(pwd: String){
        Auth.auth().currentUser?.updatePassword(to: pwd) { (error) in
            TWMessageBarManager.sharedInstance().showMessage(withTitle: "SUCCESS!", description: "Successfully Password Updated", type: .success, duration: 5.0)
        }
    }
}
