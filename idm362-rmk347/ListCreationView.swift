//
//  ListCreationView.swift
//  idm362-rmk347
//
//  Created by Roger Korpics on 3/16/23.
//

import UIKit

class ListCreationView: UITableViewController {
    
    let cellSpacingHeight: CGFloat = 5
    let backgroundColor = UIColor(named: "Background")
    
    var listItems: [String] = ["Vanilla", "Chocolate", "Strawberry", "Neapolitan"] //String containing all of the custom list items

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = backgroundColor
        tableView.separatorColor = backgroundColor
        
        tableView.layoutMargins = .init(top: 0.0, left: 23.5, bottom: 0.0, right: 23.5)
            // if you want the separator lines to follow the content width
            tableView.separatorInset = tableView.layoutMargins

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return listItems.count
    }
    


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = listItems[indexPath.row]
        cell.textLabel?.textColor = UIColor.tintColor
        cell.textLabel?.layer.cornerRadius = 8

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    //Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete from array
            listItems.remove(at: indexPath.row) //always indexPath
            //Reload table
            self.tableView.reloadData()
        }
        
        /* //Enable to add editing
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
         */
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    @IBAction func addListItem(_ sender: Any) { //Creates alert to get list item from user.
        let alertObj = UIAlertController(title: "New List Item", message: "Add New List Item", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default){
            [unowned self] action in
            guard let textField = alertObj.textFields?.first,
                  let itemToSave = textField.text else{
                return
            }
            //This line updates the array! - Rogie
            self.listItems.append(itemToSave) //You will need to use self to reference items in itself.
            //Reloads the table.
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertObj.addAction(cancelAction)
        alertObj.addTextField()
        alertObj.addAction(saveAction)
        
        present(alertObj, animated: true)
        
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
