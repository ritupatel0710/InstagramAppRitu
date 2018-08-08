//
//  Settings.swift
//  InstagramAppRitu
//
//  Created by Ritu Patel on 8/6/18.
//  Copyright © 2018 Ritu Patel. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookLogin
import FacebookCore

extension SettingsViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell")
        configureCell(cell!, indexPath)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            navigateToUpdatePasswordController()
        case 1:
            popToRootController()
        default:
            break
        }
    }
    
    func navigateToUpdatePasswordController(){
        let controller = storyboard?.instantiateViewController(withIdentifier: "UpdatePasswordViewController") as! UpdatePasswordViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func popToRootController(){
        let loginManager = LoginManager()
        loginManager.logOut()
        GIDSignIn.sharedInstance().signOut()
        //print(GIDSignIn.sharedInstance().currentUser.userID)
        signinSignOutModelObj.signOut()
        let mainStoreBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = mainStoreBoard.instantiateViewController(withIdentifier: "SignInViewController")
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
    
    func configureCell(_ cell: UITableViewCell, _ indexPath: IndexPath){
        cell.textLabel?.text = (indexPath.row == 0) ? "Update Password" : "Sign Out"
    }
}
