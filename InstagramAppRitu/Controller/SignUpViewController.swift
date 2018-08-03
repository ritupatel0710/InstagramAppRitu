
import UIKit
import FirebaseAuth
import TWMessageBarManager
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var fullNameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    var signInSignUpModelObj: SignInSignUpModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInSignUpModelObj = SignInSignUpModel()
    }
    
    @IBAction func signUpClick(_ sender: UIButton) {
        signInSignUpModelObj.signUp(fullname: fullNameTF.text!, email: emailTF.text!, username: usernameTF.text!, password: passwordTF.text!) { (error) in
            
            if error == nil{
                self.performSegue(withIdentifier: "SignInViewController", sender: nil)
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "SUCCESS!", description: "Successful Sign Up", type: .success, duration: 2.0)
            }else{
                
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "ERROR!", description: error.localizedDescription, type: .error, duration: 2.0)
            }
        }
    }
    
    
    @IBAction func signInClick(_ sender: UIButton) {
        
    }
}
