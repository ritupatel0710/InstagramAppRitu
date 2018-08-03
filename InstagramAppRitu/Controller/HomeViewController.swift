import UIKit

class HomeViewController: UIViewController {
    
    var signInSignUpModelObj : SignInSignUpModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        signInSignUpModelObj = SignInSignUpModel()
    }
    
    @IBAction func signOutClick(_ sender: UIButton) {
        signInSignUpModelObj.signOut()
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func settingsClick(_ sender: UIButton) {
    
    }
}
