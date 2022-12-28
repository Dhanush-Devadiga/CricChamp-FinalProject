//
//  ScoreboardPointsCell.swift
//  demoooo
//
//  Created by Preetam G on 12/12/22.
//

import UIKit

class ScoreboardPointsCell: UITableViewCell {

    static let identifier = "ScoreboardPointsCell"
    static let nibName = "ScoreBoardPoints"
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var matchLabel: UILabel!
    
    @IBOutlet weak var winLabel: UILabel!
    
    @IBOutlet weak var losslabel: UILabel!
    @IBOutlet weak var netRunRateLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var runrateLabel: UILabel!
    
//    func configure(name: String, match: String, win: String, loss: String, netRunRate: String, points: String, runRate: String) {
//        teamName.text = name
//        matchLabel.text = match
//        winLabel.text = win
//        losslabel.text = loss
//        netRunRateLabel.text = netRunRate
//        pointsLabel.text = points
//        runrateLabel.text = runRate
//    }
    
    func sendPointsTable(scores : TeamInfo?){
        if let scores = scores {
            teamName.text = scores.teamName
            matchLabel.text = String(scores.totalMatchesPlayed)
            winLabel.text = String(scores.totalWins)
            losslabel.text = String(scores.totalLosses)
            netRunRateLabel.text = String(scores.netRunRate)
            pointsLabel.text = String(scores.points)
            runrateLabel.text = String(scores.netRunRate)
        }
    }
}
