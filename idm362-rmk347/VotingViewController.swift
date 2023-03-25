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
    var listItemELO: [Double] = []//Keeps track of the ELO Rank of each list item
    
    var votesNeeded: Int = 0

    var chooseColumn = 0
    var chooseRow = 0
    
    var lastRowDrawn: Int?
    var lastColumnDrawn: Int?
    
    var voteTotal: Double = 0
    var voteProgress: Float = 0.0
    var votesRemaining: Int = 0
    
    var choiceA_Rating: Double = 0.0
    var choiceB_Rating: Double = 0.0
    
    //STEP 2: Find out how many rounds each list item was involved in
    var choiceA_TotalVotes: Double = 0.0
    var choiceB_TotalVotes: Double = 0.0
    
    //STEP 3: Get the expected score for each choice
    
    var difference_A_minus_B: Double  = 0.0
    var difference_B_minus_A: Double = 0.0
    var choiceA_ExpectedScore: Double = 0.0
    var choiceB_ExpectedScore: Double = 0.0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            /* print(votingListItems) */ //Uncomment to print out the list of items.
        
        // Step 1: Building each matrix
        
        //This one creates a matrix equal to the length of votingListItems squared. Each value in the array is set to "0" to denote there being no votes logged.
        votingMatrix = Array(repeating: Array(repeating: 0, count: votingListItems.count), count: votingListItems.count)
        
        //This one creates an array keeping track of the ELO for each list item.
        listItemELO = Array(repeating: 1000, count: votingListItems.count)
        
        drawRound()
        
        votesRemaining = votesNeeded / 2
        VotesNeededLabel.text = String(votesRemaining) + " Votes Needed"
        VotePercentageLabel.text = String(round(voteProgress * 1000) / 10) + "% Complete"
    }
    
    
    @IBOutlet weak var LeftButtonUI: UIButton!
    
    @IBOutlet weak var RightButtonUI: UIButton!    
    
    @IBAction func LeftButton(_ sender: Any) {
        assignPoints(chosen: chooseColumn, rejected: chooseRow) //Assigns points in ELO and Voting Matrix
        drawRound() //Draws a new round
        VotingProgressBar.setProgress(voteProgress, animated: true)
        votesRemaining -= 1
        VotesNeededLabel.text = String(votesRemaining) + " Votes Needed"
        VotePercentageLabel.text = String(round(voteProgress * 1000) / 10) + "% Complete"
    }
    
    
    @IBAction func RightButton(_ sender: Any) {
        assignPoints(chosen: chooseRow, rejected: chooseColumn) //Assigns points in ELO and Voting Matrix
        drawRound() //Draws a new round
        VotingProgressBar.setProgress(voteProgress, animated: true)
        votesRemaining -= 1
        VotesNeededLabel.text = String(votesRemaining) + " Votes Needed"
        VotePercentageLabel.text = String(round(voteProgress * 1000) / 10) + "% Complete"
    }
    
    func drawRound(){ //This function creates a pair up between two items.
        votesNeeded = ((votingListItems.count * votingListItems.count) - votingListItems.count)
        voteProgress = Float(Double(voteTotal) / (Double(votesNeeded ) / 2))

        let idealAverage = 1 / Double(votesNeeded ) //This is used to determine the ideal frequency a pair should be voted on – as expressed as a percentage.
       
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
        print("Voting Matrix:")
        print(votingMatrix)
        
        //Sets the last row drawn to new variables
        lastRowDrawn = chooseRow
        lastColumnDrawn = chooseColumn
        
        // ELO CALCULATIONS

        //STEP 1: Find the current ELO rating of each list item
        choiceA_Rating = listItemELO[chooseRow]
        choiceB_Rating = listItemELO[chooseColumn]
        
        //STEP 2: Find out how many rounds each list item was involved in
        choiceA_TotalVotes = votingMatrix[chooseRow].reduce(0, +)
        choiceB_TotalVotes = votingMatrix[chooseColumn].reduce(0, +)
        
        //STEP 3: Get the expected score for each choice
        
        difference_A_minus_B = choiceA_Rating - choiceB_Rating
        difference_B_minus_A = choiceB_Rating - choiceA_Rating
        choiceA_ExpectedScore = 1 / (1 + pow(10, difference_B_minus_A / 1000))
        choiceB_ExpectedScore = 1 / (1 + pow(10, difference_A_minus_B / 1000))
        
        LeftButtonUI.setTitle(String(votingListItems[chooseColumn]), for: .normal) //Changes the label for the left button
        RightButtonUI.setTitle(String(votingListItems[chooseRow]), for: .normal) //Changes the label for the right button

    }
    
    
    
    func assignPoints(chosen: Int, rejected: Int){
        votingMatrix[chosen][rejected] += 1
        votingMatrix[rejected][chosen] += 1
        voteTotal += 1
        
        //Alright, now for the hard part. Time to run the ELO!
        
        if (listItemELO[chooseRow] == listItemELO[chosen]){
            listItemELO[chosen] = choiceA_Rating + 100 * (1 - choiceA_ExpectedScore)
            listItemELO[rejected] = choiceB_Rating + 100 * (0 - choiceB_ExpectedScore)
            if (listItemELO[rejected] <= 0.0){
                listItemELO[rejected] = 1
            }
        }
        
        if (listItemELO[chooseColumn] == listItemELO[chosen]){
            listItemELO[chosen] = choiceB_Rating + 100 * (1 - choiceB_ExpectedScore)
            listItemELO[rejected] = choiceA_Rating + 100 * (0 - choiceA_ExpectedScore)
            if (listItemELO[rejected] <= 0.0){
                listItemELO[rejected] = 1
            }
        }
        
        print(listItemELO)
        
    }
    
    //Progress Bar
    
    @IBOutlet weak var VotingProgressBar: UIProgressView!
    
    @IBOutlet weak var VotesNeededLabel: UILabel!
    
    @IBOutlet weak var VotePercentageLabel: UILabel!
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
