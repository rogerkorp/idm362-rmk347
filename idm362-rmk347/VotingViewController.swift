//
//  VotingViewController.swift
//  idm362-rmk347
//
//  Created by Roger Korpics on 3/22/23.
//

import UIKit

class VotingViewController: UIViewController {
    
    //List Variable
    
    var votingListItems: [String] = [] //List passed from the creation screen
    
    var votingMatrix: [[String]] = [] //Keeps track of how many votes each pair has recieved
    var listItemELO: [String] = []//Keeps track of the ELO Rank of each list item

    var chooseColumn = 0
    var chooseRow = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            /* print(votingListItems) */ //Uncomment to print out the list of items.
        
        // Step 1: Building each matrix
        
        //This one creates a matrix equal to the length of votingListItems squared. Each value in the array is set to "0" to denote there being no votes logged.
        let votingMatrix = Array(repeating: Array(repeating: 0, count: votingListItems.count), count: votingListItems.count)
        
        var idealAverage = 1 / (((votingListItems.count) * (votingListItems.count)) - (votingListItems.count)) //This is used to determine the ideal frequency a pair should be voted on – as expressed as a percentage.
        
        //This one creates an array keeping track of the ELO for each list item.
        let listItemELO = Array(repeating: 1000, count: votingListItems.count)
        
        
        
        print(votingMatrix)
        drawRound()
    }
    
    
    @IBOutlet weak var LeftButtonUI: UIButton!
    
    @IBOutlet weak var RightButtonUI: UIButton!    
    
    @IBAction func LeftButton(_ sender: Any) {
    }
    
    
    @IBAction func RightButton(_ sender: Any) {
    }
    
    func drawRound(){ //This function creates a pair up between two items.
        
        let chooseRow = Int.random(in: 0...votingListItems.count) //First it draws the row
        
        repeat { //Then it will draw the column. Note how it always redraws if the column is the same as the row. This will prevent the system from choosing pair-ups between the same two objects.
        let chooseColumn = Int.random(in: 0...votingListItems.count)
        } while (chooseColumn == chooseRow)
        
        print(votingListItems[chooseColumn], votingListItems[chooseRow])
        
        LeftButtonUI.setTitle(String(votingListItems[chooseColumn]), for: .normal)
        RightButtonUI.setTitle(String(votingListItems[chooseRow]), for: .normal)
        

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
