//
//  CurrentUser.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/2/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import Foundation
class CurrentUser: NSObject{
    
    private override init() {}
    static let sharedInstance = CurrentUser()
    
    var userId: String!
    var email: String!
    var fullname: String?
    var password: String?
    var imageURL: String?
    var postId: String?
}
