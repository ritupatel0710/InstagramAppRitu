
import UIKit
import FirebaseAuth
import TWMessageBarManager

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    var signInSignUpModelObj : SignInSignUpModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInSignUpModelObj = SignInSignUpModel()
    }
    
    @IBAction func signInClick(_ sender: UIButton) {
        signInSignUpModelObj.signIn(email: emailTF.text!, password: passwordTF.text!)
    }
    
    @IBAction func forgotPasswordClick(_ sender: UIButton) {
        
    }
    @IBAction func signUpClick(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
