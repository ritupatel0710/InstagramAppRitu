
import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.isNavigationBarHidden = true
        //tblView.tableFooterView = view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell")
        
        switch indexPath.row {
    
        case 0:
            cell?.textLabel?.text = "Update Password"
            let controller = storyboard?.instantiateViewController(withIdentifier: "UpdatePasswordViewController") as! UpdatePasswordViewController
            navigationController?.pushViewController(controller, animated: true)
        case 1:
            cell?.textLabel?.text = "Sign Out"
            navigationController?.popToRootViewController(animated: true)
            
        default:
            break
        }
        
        return cell!
    }
}
