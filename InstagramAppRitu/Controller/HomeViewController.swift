//
//  HomeViewController.swift
//  Instagram
//
//  Created by Cheeja on 5/28/18.
//  Copyright © 2018 Cheeja. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    var arrpost = Array<Dictionary<String,Any>>()
    var signInSignUpModelObj : SignInSignUpModel!
    var arrpostObj : Array<Posts> = []
    var arrUserPhoto : Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.tblView.rowHeight = 520.0
        signInSignUpModelObj = SignInSignUpModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        //getUsersPost()
        getAllPosts()
    }
    
    func getAllPosts(){
        signInSignUpModelObj.getAllUsersPosts { (arrPosts) in
            self.arrpostObj = arrPosts
            print(arrPosts)
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }
    
//    func getUsersPost(){
//        signInSignUpModelObj.getUsersPost { (postInstances) in
//            self.arrpostObj = postInstances
//            DispatchQueue.main.async {
//                self.tblView.reloadData()
//            }
//               // print(item.imageURL)
//
//            //arrayDict.sorted { self.sort(p1:$0, p2:$1) }
//
////            for item in arrayDict{
////
////                print(item["userId"]!)
////                print(item["postDescription"]!)
////                print(item["timestamp"]!)
////                //self.postInstance.imageURL = postSnapshot["imageURL"]
////            }
//
//        }
//    }

//    func sort(p1:Dictionary<String,Any>, p2:Dictionary<String,Any> ) -> Bool{
//        let x1 = p1["timestamp"] as! String
//        let x2 = p1["timestamp"] as! String
//        return x1 < x2
//    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(arrpostObj.count)
        return arrpostObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell

        
        let postphoturl = arrpostObj[indexPath.row].userObject?.imageURL
    
            if let imgstr = CurrentUser.sharedInstance.imageURL{
                cell.userProfilePhoto.sd_setImage(with: URL(string: imgstr))
            }else{
                cell.userProfilePhoto.image = UIImage(named: "launch")
            }
            
        cell.userNameLabel.text = arrpostObj[indexPath.row].userObject?.fullname
            
            cell.postPhoto.sd_setImage(with: URL(string: postphoturl!))
            
            cell.postDescriptionLabel.text = self.arrpostObj[indexPath.row].postDescription
            
            cell.numberOfLikesLabel.text = "400 Likes"
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 520.0
    }
}

