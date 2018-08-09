//
//  Comment.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/8/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import Foundation
class Comment{
    var commentId: String?
    var postId: String?
    var userId: String?
    var commentDescription: String?
    
    init(commentId: String?, postId: String?,userId: String?, commentDescription: String?){
        self.commentId = commentId
        self.postId = postId
        self.userId = userId
        self.commentDescription = commentDescription
    }
}
