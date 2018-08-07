//
//  UserListViewController.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/6/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import UIKit
import SDWebImage

class UserListViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var signinSignOutModelObj = SignInSignUpModel()
    var arrUsersObj = Array<User?>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tblView.tableFooterView = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllUser()
    }
    func getAllUser(){
        signinSignOutModelObj.getAllUserList { (arrayUser) in
            self.arrUsersObj = arrayUser
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }
    
    
}

extension UserListViewController : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUsersObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell") as? UserListTableViewCell
        configureCell(cell!,indexPath)
        return cell!
    }
    
    func configureCell(_ cellTable: UITableViewCell, _ indexPath: IndexPath){
        
        let cell = cellTable as? UserListTableViewCell
        let userObj = arrUsersObj[indexPath.row]
        if let img = userObj?.imageURL{
            cell?.userProfilePhoto.sd_setImage(with: URL(string: img))
        }
        cell?.fullname.text = userObj?.fullname
        
        //Very Important step because using this line of code, I will have userId
        cell?.addFriendClick.tag = indexPath.row
        cell?.addFriendClick.addTarget(self, action: #selector(addFriendClicks(sender:)) , for: .touchUpInside)
    }
    
    @objc func addFriendClicks(sender: UIButton?){
        
        if UIImage(named:"addFriend") != nil {
            let useridForFriendReq = arrUsersObj[(sender?.tag)!]?.userId
            sender?.setImage( UIImage(named:"friendAdded"), for: .normal)
            self.addUserAsFriend(useridForFriendReq!)
        }
    }
    
    func addUserAsFriend(_ userIdFriend : String){
        signinSignOutModelObj.addUserAsFriend(userIdFriend)
    }
}
