//
//  FriendsViewController.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/6/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import UIKit
import SDWebImage

class FriendsViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var arrFriend = Array<User?>()
    var signinSignOutModelObj = SignInSignUpModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tblView.tableFooterView = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMyFriends()
    }
    
    func getMyFriends(){
        signinSignOutModelObj.getMyAllFriends { (arrayFriend) in
            self.arrFriend = arrayFriend
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFriend.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell") as! FriendTableViewCell
        configureCell(cell, indexPath)
        return cell
    }
    
    func configureCell(_ cellTable: UITableViewCell, _ indexPath: IndexPath){
        
        let cell = cellTable as? FriendTableViewCell
        let friend = arrFriend[indexPath.row]
        cell?.friendName.text = friend?.fullname
        
        if let url = friend?.imageURL{
            cell?.friendPhoto.sd_setImage(with: URL(string: url))
        }
    }
    
}
