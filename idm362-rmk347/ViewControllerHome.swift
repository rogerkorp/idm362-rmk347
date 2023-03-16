//
//  ViewControllerHome.swift
//  idm362-rmk347
//
//  Created by Roger Korpics on 3/15/23.
//

import UIKit

class ViewControllerHome: UIViewController {
    
    var itemList: [String] = [] // This is the array that stores alll of the list items
    
    @IBOutlet weak var ListItemTextInput: UITextField!
    
    @IBAction func AddListItem(_ sender: Any) { //This initiates an action after clicking the "add" button
        
        guard let newListItem = ListItemTextInput.text else{ //This changes the value of local variable "newListItem" to equal that of "ListItemTextInput" Guard is needed here so that it cannot pass "nil" variables
            return
        }
        
        if newListItem.isEmpty{ //After reading it to prevent 'nil' values, this checks if the string is blank. If it is, then the process is terminated.
            print("You can not add blank strings, no matter how hard you try.")
            return
        }
        
        self.itemList.append(newListItem) //Adds text from ListItemTextInput into the itemList Array
        print(itemList) //Prints the variable into the console log
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
