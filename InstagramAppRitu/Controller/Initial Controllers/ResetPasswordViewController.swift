
import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    var signInSignUpModelObj : SignInSignUpModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInSignUpModelObj = SignInSignUpModel()
    }
    
    @IBAction func resetPasswordClick(_ sender: UIButton) {
        signInSignUpModelObj.resetPassword(email: emailTF.text!)
    }
}
