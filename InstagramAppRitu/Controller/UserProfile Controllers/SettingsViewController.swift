
import UIKit

class SettingsViewController: UIViewController{
    
    @IBOutlet weak var tblView: UITableView!
    
    var signinSignOutModelObj = SignInSignUpModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
}
