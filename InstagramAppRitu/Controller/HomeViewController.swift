
import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!

    var signInSignUpModelObj : SignInSignUpModel!
    var arrpostObj : Array<Posts> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.isNavigationBarHidden = true
        self.tblView.rowHeight = 580.0
        signInSignUpModelObj = SignInSignUpModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
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
    
    @IBAction func noofLikesClick(_ sender: UIButton) {
        
    }
}

