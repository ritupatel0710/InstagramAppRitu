//
//  User.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/5/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import Foundation

class User: NSObject{
    var userId: String!
    var email: String!
    var fullname: String?
    var password: String?
    var imageURL: String?
    var postId: String?
    
    init(userId: String,email: String,fullname: String,password: String?,imageURL: String?,postId: String?){
        
        self.userId = userId
        self.email = email
        self.fullname = fullname
        self.password = password
        self.imageURL = imageURL
        self.postId = postId
    }
}
