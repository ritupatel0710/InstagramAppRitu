//
//  HomeController.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/6/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import UIKit
import SDWebImage

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrpostObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell")
        
        configureCell(cell!,indexPath)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 580.0
    }
    
    func configureCell(_ cellofTable: UITableViewCell, _ indexPath: IndexPath){
        
        let cell = cellofTable as! HomeTableViewCell
        
        let postObj = arrpostObj[indexPath.row]
        
        let userObj = postObj.userObject
        
        if let imgstr = userObj?.imageURL, let postpicurl = postObj.imageURL{
            cell.userProfilePhoto.sd_setImage(with: URL(string: imgstr))
            cell.postPhoto.sd_setImage(with: URL(string: postpicurl))
        }else{
            cell.userProfilePhoto.image = UIImage(named: "launch")
        }
        
        cell.userNameLabel.text = userObj?.fullname
        
        cell.postDescriptionLabel.text = postObj.postDescription
        
        cell.numberOfLikesLabel.text = "400 Likes"
    }
}
