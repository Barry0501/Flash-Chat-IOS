

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        titleLabel.text = "";
        let titleText = "⚡️FlashChat";
        var charIdx = 0.0;
        
        for letter in titleText{
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIdx, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter);
            }
            charIdx+=1.5;
        }
    }
    

}
