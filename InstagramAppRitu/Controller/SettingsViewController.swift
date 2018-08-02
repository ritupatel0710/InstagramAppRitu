
import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    
    var arr = ["Upddate Password", "Signout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        //tblView.tableFooterView = view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell")
        cell?.textLabel?.text = arr[indexPath.row]
        return cell!
    }
}
