//
//  Posts.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/3/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import Foundation
class Posts: NSObject{
    
    struct Static {
        static var instance: Posts?
    }
    
    class var sharedInstance: Posts {
        if Static.instance == nil
        {
            Static.instance = Posts()
        }
        
        return Static.instance!
    }
    
    private override init() {}
    
    var postId : String!
    var userId : String!
    var postDescription : String?
    var timestamp : String?
    
}
