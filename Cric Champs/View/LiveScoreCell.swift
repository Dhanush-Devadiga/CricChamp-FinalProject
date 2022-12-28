//
//  LiveScoreCell.swift
//  ManageViewController
//
//  Created by Dhanush Devadiga on 15/12/22.
//

import UIKit

class LiveScoreCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var over: UILabel!
    @IBOutlet weak var currentRunRate: UILabel!
    @IBOutlet weak var requiredRunrate: UILabel!
    @IBOutlet weak var caption: UILabel!
    
    func setData(team: TeamScore, inningsStatus: Bool) {
        let score = String(team.run) + "/" + String(team.wicket)
        let over = String(team.over) + "." + String(team.ball)
        
        self.name.text = team.teamName
        self.score.text = score
        self.over.text = "(" + over + ")"
        self.currentRunRate.text = String(team.currentRunRate)
        if inningsStatus {
            self.requiredRunrate.text = "0.0"
            self.caption.isHidden = true
        } else {
            self.caption.isHidden = false
            if team.requiredRunsToWin > 0 {
                self.requiredRunrate.text = String(team.requiredRunRate)
                self.caption.text = team.teamName + " need " + String(team.requiredRunsToWin) + " to win"
                self.caption.textColor = #colorLiteral(red: 0.8784313725, green: 0.3176470588, blue: 0.2509803922, alpha: 1)
            } else {
                self.requiredRunrate.text = String(team.requiredRunRate)
                self.caption.text = team.teamName + "Won The Match"
                self.caption.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
            
        }

    }
}
