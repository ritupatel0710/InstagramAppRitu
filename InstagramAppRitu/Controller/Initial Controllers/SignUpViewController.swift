
import UIKit
import FirebaseAuth
import TWMessageBarManager
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var fullNameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var confirmPwdTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    var signInSignUpModelObj: SignInSignUpModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInSignUpModelObj = SignInSignUpModel()
    }
    
    @IBAction func signUpClick(_ sender: UIButton) {
        if confirmPwdTF.text != passwordTF.text{
            TWMessageBarManager.sharedInstance().showMessage(withTitle: "Oops!", description: "Passwords doesn't match", type: .success, duration: 2.0)
        }else{
            signUp()
        }
    }
    
    
    @IBAction func signInClick(_ sender: UIButton) {
        
    }
    
    func signUp(){
        signInSignUpModelObj.signUp(fullname: fullNameTF.text!, email: emailTF.text!,password: passwordTF.text!) { (error) in
            
            if error == nil{
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "SignInViewController", sender: self)
                    TWMessageBarManager.sharedInstance().showMessage(withTitle: "SUCCESS!", description: "Successful Sign Up", type: .success, duration: 2.0)
                }
            }else{
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "ERROR!", description: error?.localizedDescription, type: .error, duration: 2.0)
            }
        }
    }
}
