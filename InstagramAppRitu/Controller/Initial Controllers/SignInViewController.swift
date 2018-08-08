
import UIKit
import FirebaseAuth
import TWMessageBarManager
import GoogleSignIn
import FacebookCore
import FacebookLogin

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
                    let userId = authResult?.user.uid
                    let email = authResult?.user.email
                    let fullName = authResult?.user.displayName
                    self.signInSignUpModelObj.signinwithGoogle(userId!, email!, fullName!)
                    self.performSegue(withIdentifier: "TabBarController", sender: nil)
                    //authResult?.user.
                }
            }
        }
    }
    @IBAction func signinFacebook(_ sender: UIButton) {
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile,.email], viewController: self) { (result) in
            switch result{
            case .success(grantedPermissions: _, declinedPermissions: _, token: _):
                self.signinFirebase()
                print("Sign in with FB")
            case .failed: print("error")
            case .cancelled: print("cancelled")
            default:break
                
            }
        }
    }
    
    func signinFirebase(){
        signInSignUpModelObj.signInFB()
        self.performSegue(withIdentifier: "TabBarController", sender: nil)
    }

    /*
     Save it to database
     
     */
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
