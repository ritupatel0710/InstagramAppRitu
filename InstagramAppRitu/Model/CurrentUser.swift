//
//  CurrentUser.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/2/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import Foundation
class CurrentUser: NSObject{
    
    struct Static {
        static var instance: CurrentUser?
    }
    
    class var sharedInstance: CurrentUser {
        if Static.instance == nil
        {
            Static.instance = CurrentUser()
        }
        
        return Static.instance!
    }
    
    private override init() {}
    
    var userId: String!
    var email: String!
    var fullname: String?
    var password: String?
    var username: String?
    var imageURL: String?
}
