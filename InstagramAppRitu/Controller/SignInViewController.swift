
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
        signInSignUpModelObj.signIn(email: emailTF.text!, password: passwordTF.text!) { (error) in
            print(error)
            if error == nil{
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "SUCCESS!", description: "Successful Sign Up", type: .success, duration: 2.0)
                self.performSegue(withIdentifier: "tabbarController", sender: sender)
            }else{
                
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "ERROR!", description: error.localizedDescription, type: .error, duration: 2.0)
            }
        }
    }
    
    @IBAction func forgotPasswordClick(_ sender: UIButton) {
        
    }
    @IBAction func signUpClick(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
