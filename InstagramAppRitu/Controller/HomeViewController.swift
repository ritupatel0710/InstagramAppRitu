import UIKit

class HomeViewController: UIViewController {
    
    var signInSignUpModelObj : SignInSignUpModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        signInSignUpModelObj = SignInSignUpModel()
        getUsersPost()
    }
    
    @IBAction func signOutClick(_ sender: UIButton) {
        signInSignUpModelObj.signOut()
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func settingsClick(_ sender: UIButton) {
    
    }
    
    func getUsersPost(){
        signInSignUpModelObj.getUsersPost { (arrayDict) in
            
            arrayDict.sorted { self.sort(p1:$0, p2:$1) }
            
            for item in arrayDict{
                
                print(item["userId"]!)
                print(item["postDescription"]!)
                print(item["timestamp"]!)
                //self.postInstance.imageURL = postSnapshot["imageURL"]
            }
        }
    }
    
    func sort(p1:Dictionary<String,Any>, p2:Dictionary<String,Any> ) -> Bool{
        let x1 = p1["timestamp"] as! String
        let x2 = p1["timestamp"] as! String
        return x1 < x2
    }
}
