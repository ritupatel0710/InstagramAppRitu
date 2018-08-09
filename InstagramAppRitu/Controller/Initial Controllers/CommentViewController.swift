//
//  CommentViewController.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/8/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var comment: UITextField!
    
    @IBOutlet weak var tblView: UITableView!
    
    var signInSignOutModelObj : SignInSignUpModel!
    var postidforComment = ""
    var commentObjArr = Array<Comment>()
    var userObjArr = Array<User>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInSignOutModelObj = SignInSignUpModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        signInSignOutModelObj.getCommentedUsers(postidforComment) { (commentArr, userArr) in
            self.commentObjArr = commentArr
            self.userObjArr = userArr
            
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }

    @IBAction func addCommentClick(_ sender: UIButton) {
        if let commentText = comment.text{
            signInSignOutModelObj.addComment(commentText,postidforComment)
            viewWillAppear(true)
            comment.text = ""
        }
    }
    
}

extension CommentViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentObjArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
        let userobj = userObjArr[indexPath.row]
        let commentobj = commentObjArr[indexPath.row]
        cell.fullname.text = userobj.fullname
        cell.commentLbl.text = commentobj.commentDescription
        if let imgurl = userobj.imageURL{
            cell.profilePhoto.sd_setImage(with: URL(string: imgurl))
        }
        return cell
    }
    
}
