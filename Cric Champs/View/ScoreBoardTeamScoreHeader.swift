//
//  ScoreBoardTeamScoreHeader.swift
//  LiveScoreProject
//
//  Created by Dhanush Devadiga on 17/12/22.
//

import UIKit

protocol  SetUpDropDown {
    func displayTeam()
}
class ScoreBoardTeamScoreHeader: UITableViewHeaderFooterView {
    var delegate: SetUpDropDown?
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var over: UILabel!
    
    func setScore(data: TeamScoreBoard?) {
        if let data = data {
            teamName.text = data.teamName
            score.text = String(data.score) + "/" + String(data.totalWicketFall)
            over.text = "(" + String(data.overs) + "." + String(data.ball) + ")"
        } else {
            setDefaultValue()
        }
        
    }
    
    @IBAction func onClickDropDown(_ sender: Any) {
        delegate?.displayTeam()
    }
    
    private func setDefaultValue() {
        teamName.text = ""
        score.text = ""
        over.text = ""
    }
}
