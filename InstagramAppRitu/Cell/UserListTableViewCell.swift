//
//  UserListTableViewCell.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/6/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfilePhoto: UIImageView!
    
    @IBOutlet weak var fullname: UILabel!
    
    @IBOutlet weak var addFriendClick: UIButton!
    
    var signinSignUpModelObj = SignInSignUpModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addUser(_ sender: UIButton) {
        if UIImage(named:"addFriend") != nil {
            sender.setImage( UIImage(named:"friendAdded"), for: .normal)
            addUserAsFriend()
        }
        
    }
    
    func addUserAsFriend(){
        //signinSignUpModelObj
    }
}
