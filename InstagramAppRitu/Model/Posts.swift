//
//  Posts.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/3/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import Foundation
class Posts: NSObject{

    var postId : String!
    var userId : String!
    var postDescription : String?
    var timestamp : Double?
    var imageURL: String?
    var userObject : User?
    var commentObj: Comment?
    
    init(_ postId: String?, _ userId:String?, _ postDescription: String?, _ timestamp: Double?, _ imageURL: String?, _ userObject: User?,_ commentObj:Comment?){
        
        self.postId = postId
        self.userId = userId
        self.postDescription = postDescription
        self.timestamp = timestamp
        self.imageURL = imageURL
        self.userObject = userObject
        self.commentObj = commentObj
    }
}
