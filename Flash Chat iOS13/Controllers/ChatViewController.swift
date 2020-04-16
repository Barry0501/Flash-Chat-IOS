

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore();
    
    var messages: [Message] = [
        Message(sender: "1@2.com", body: "Hey!"),
        Message(sender: "a@.com", body: "Hey!"),
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        tableView.dataSource = self;
        navigationItem.hidesBackButton = true;
        title = Constants.appName;
        
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier);
        
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text,
            let messageSender = Auth.auth().currentUser?.email{
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                Constants.FStore.senderField: messageSender,
                Constants.FStore.bodyField: messageBody,
            ]) { (error) in
                if let e = error{
                    print("There was an error when sending data to firebase with e = \(e)");
                }else{
                    print("successfully");
                }
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell;
        
        cell.textLabel?.text = messages[indexPath.row].body;
        return cell;
    }
    
}
