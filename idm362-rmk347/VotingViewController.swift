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
    
    var votingMatrix: [[Double]] = [] //Keeps track of how many votes each pair has recieved
    var listItemELO: [String] = []//Keeps track of the ELO Rank of each list item
    
    var votesNeeded: Int?

    var chooseColumn = 0
    var chooseRow = 0
    
    var lastRowDrawn: Int?
    var lastColumnDrawn: Int?
    
    var voteTotal: Double = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            /* print(votingListItems) */ //Uncomment to print out the list of items.
        
        // Step 1: Building each matrix
        
        //This one creates a matrix equal to the length of votingListItems squared. Each value in the array is set to "0" to denote there being no votes logged.
        votingMatrix = Array(repeating: Array(repeating: 0, count: votingListItems.count), count: votingListItems.count)
        
        //This one creates an array keeping track of the ELO for each list item.
        let listItemELO = Array(repeating: 1000, count: votingListItems.count)
        
        drawRound()
    }
    
    
    @IBOutlet weak var LeftButtonUI: UIButton!
    
    @IBOutlet weak var RightButtonUI: UIButton!    
    
    @IBAction func LeftButton(_ sender: Any) {
        assignPoints(chosen: chooseColumn, rejected: chooseRow) //Assigns points in ELO and Voting Matrix
        drawRound() //Draws a new round
    }
    
    
    @IBAction func RightButton(_ sender: Any) {
        assignPoints(chosen: chooseRow, rejected: chooseColumn) //Assigns points in ELO and Voting Matrix
        drawRound() //Draws a new round
    }
    
    func drawRound(){ //This function creates a pair up between two items.
        votesNeeded = ((votingListItems.count * votingListItems.count) - votingListItems.count)

        var idealAverage = 1 / Double(votesNeeded ?? 1) //This is used to determine the ideal frequency a pair should be voted on – as expressed as a percentage.
       
        repeat{
            repeat{
                chooseRow = Int.random(in: 0...(votingListItems.count - 1)) //First it draws the row
            } while (chooseRow == lastRowDrawn)
        
            repeat { //Then it will draw the column. Note how it always redraws if the column is the same as the row. This will prevent the system from choosing pair-ups between the same two objects.
                chooseColumn = Int.random(in: 0...(votingListItems.count - 1))
            } while ((chooseColumn == lastColumnDrawn) || (chooseColumn == chooseRow))
            
        } while ((votingMatrix[chooseColumn][chooseRow])/(voteTotal*2) > idealAverage)
                    
                    
        print("Total Votes Logged: ", voteTotal)
        print("Ideal Average: ", idealAverage)
        print("Voting Matrix")
        print(votingMatrix)
        
        //Sets the last row drawn to new variables
        lastRowDrawn = chooseRow
        lastColumnDrawn = chooseColumn
        
        LeftButtonUI.setTitle(String(votingListItems[chooseColumn]), for: .normal) //Changes the label for the left button
        RightButtonUI.setTitle(String(votingListItems[chooseRow]), for: .normal) //Changes the label for the right button

    }
    
    func assignPoints(chosen: Int, rejected: Int){
        print(chosen)
        print(rejected)
        votingMatrix[chosen][rejected] += 1
        votingMatrix[rejected][chosen] += 1
        voteTotal += 1
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
