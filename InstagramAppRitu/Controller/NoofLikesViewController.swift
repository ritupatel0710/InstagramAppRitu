//
//  NoofLikesViewController.swift
//
//
//  Created by Ritu Patel on 8/8/18.
//

import UIKit

class NoofLikesViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    var postIdforLike = ""
    var signInSignOutModelObj : SignInSignUpModel!
    var arrayUserObj = Array<User>()
    override func viewDidLoad() {
        super.viewDidLoad()
        signInSignOutModelObj = SignInSignUpModel()
        tblView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        signInSignOutModelObj.getUserPostLiked(postIdforLike) { (userArr) in
                print(userArr.count)
                self.arrayUserObj = userArr
                //print(arrayUserObj)
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
        }
    }
}

extension NoofLikesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayUserObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell") as! FriendTableViewCell
        let userobj = arrayUserObj[indexPath.row]
        cell.friendName.text = userobj.fullname
        print(userobj.fullname)
        if let imgurl = userobj.imageURL{
            cell.friendPhoto.sd_setImage(with: URL(string: imgurl))
        }
        return cell
    }
    
    
}
