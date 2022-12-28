//
//  MatchCell.swift
//  demoooo
//
//  Created by Preetam G on 12/12/22.
//

import UIKit

class MatchTableCell: UITableViewCell {

    static let identifier = "MatchCell"
    static let nibName = "Match"

    @IBOutlet weak var matchNumberLabel: UILabel!
    @IBOutlet weak var groundNumberLabel: UILabel!
    @IBOutlet weak var matchStatusLabel: UILabel!
    
    @IBOutlet weak var teamOneNameLabel: UILabel!
    @IBOutlet weak var teamTwoNameLabel: UILabel!
    @IBOutlet weak var teamOneScoreLabel: UILabel!
    @IBOutlet weak var teamTwoScoreLabel: UILabel!
    @IBOutlet weak var teamOneOversLabel: UILabel!
    @IBOutlet weak var teamTwoOversLabel: UILabel!
    @IBOutlet weak var matchStatusDescriptionLabel: UILabel!
    
    func configure(matchNumber: String, groundNumber: String, matchStatus: MatchCellStatus, teamOneName: String, teamTwoName: String, teamOneScore: String, teamTwoScore: String, teamOneOvers: String, teamTwoOvers: String, matchStatusDescription: String) {
        
        matchNumberLabel.text = "Match \(matchNumber)"
        groundNumberLabel.text = "League Play at Ground \(groundNumber)"
        configureMatchStatus(matchStatus: matchStatus)
        teamOneNameLabel.text = teamOneName
        teamTwoNameLabel.text = teamTwoName
        teamOneScoreLabel.text = teamOneScore
        teamTwoScoreLabel.text = teamTwoScore
        teamOneOversLabel.text = teamOneOvers
        teamTwoOversLabel.text = teamTwoOvers
        matchStatusDescriptionLabel.text = matchStatusDescription
        
    }
    
    private func configureMatchStatus(matchStatus: MatchCellStatus) {
        matchStatusLabel.text = " \(matchStatus.rawValue) "
        switch matchStatus {
        case .ABONDONED: matchStatusLabel.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.3176470588, blue: 0.2509803922, alpha: 1)
        case .LIVE: matchStatusLabel.backgroundColor = #colorLiteral(red: 0.137254902, green: 0.7529411765, blue: 0.3607843137, alpha: 1)
        case .PAST: matchStatusLabel.backgroundColor = #colorLiteral(red: 0, green: 0.4588235294, blue: 0.8823529412, alpha: 1)
        case .UPCOMING: matchStatusLabel.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.662745098, blue: 0, alpha: 1)
        default : matchNumberLabel.backgroundColor = #colorLiteral(red: 0, green: 0.4588235294, blue: 0.8823529412, alpha: 1)
        }
        
    }
}

