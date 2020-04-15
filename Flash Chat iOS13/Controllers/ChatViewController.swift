

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messages: [Message] = [
        Message(sender: "1@2.com", body: "Hey!"),
        Message(sender: "a@.com", body: "Hey!"),
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        tableView.dataSource = self;
        navigationItem.hidesBackButton = true;
        title = Constants.appName;
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    

    @IBAction func handleLogOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut();
            
            navigationController?.popToRootViewController(animated: true);
            
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
          
    }
}

extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath);
        
        cell.textLabel?.text = messages[indexPath.row].body;
        return cell;
    }
    
}
