
import UIKit
import FirebaseAuth
import TWMessageBarManager
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    var signInSignUpModelObj : SignInSignUpModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInSignUpModelObj = SignInSignUpModel()
    }
    
    // Google code start
    
    @IBAction func google(_ sender: Any) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signIn()// signout also there
       return
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error == nil{
            guard let authentication = user.authentication else{return}
            let cred = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            Auth.auth().signInAndRetrieveData(with: cred) { (authResult, error) in
                if error == nil{
                    print(authResult?.user.uid)
                }
            }
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
    // Above code is for Google
    
    @IBAction func signInClick(_ sender: UIButton) {
        signInSignUpModelObj.signIn(email: emailTF.text!, password: passwordTF.text!) { (error) in
            print(error)
            
            if error == nil{
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "SUCCESS!", description: "Successful Sign Up", type: .success, duration: 2.0)
                self.performSegue(withIdentifier: "TabBarController", sender: sender)
            }else{
                
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "ERROR!", description: error?.localizedDescription, type: .error, duration: 2.0)
            }
        }
    }
    
    @IBAction func forgotPasswordClick(_ sender: UIButton) {
        
    }
    @IBAction func signUpClick(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
