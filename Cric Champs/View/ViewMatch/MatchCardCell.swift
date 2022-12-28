//
//  MatchCell.swift
//  demoooo
//
//  Created by Preetam G on 12/12/22.
//

import UIKit

class MatchCardCell: UITableViewCell {

    var currentMatchStatus: MatchStatus = .UPCOMING

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
    
//    func sendMatchDetails(match: viewMatch) {
//
//        self.matchNumberLabel.text = "Match \(String(match.matchNumber))"
//
//        self.groundNumberLabel.text = "At Ground Number \(String(match.groundId))"
//        configureMatchStatus(matchStatus: MatchCellStatus(rawValue: match.matchStatus)!)
//
//    }
//
//    func sendTeamsdetails(vers: [VTeams]) {
//
//        self.teamOneNameLabel.text = vers[0].teamName
//
//        self.teamTwoNameLabel.text = vers[1].teamName
//
//        self.teamOneScoreLabel.text = String("\(vers[0].totalScore)/\(vers[0].totalWickets)")
//
//        self.teamTwoScoreLabel.text = String("\(vers[1].totalScore)/\(vers[1].totalWickets)")
//
//        self.teamOneOversLabel.text = String("(\(vers[0].totalOverPlayed).\(vers[0].totalBallsPlayed))")
//
//        self.teamTwoOversLabel.text = String("(\(vers[0].totalOverPlayed).\(vers[1].totalBallsPlayed))")
//
//    }
    func sendVersusMatchesData(vmatch : MatchInfo)
    {
//        self.matchNumberLabel.text = "Match \(String(vmatch.))"
        self.groundNumberLabel.text = "At \(String(vmatch.groundName))ground"
        
        // updating labels
        
        configureMatchStatus(matchStatus: MatchCellStatus(rawValue: vmatch.matchStatus)!)
        if vmatch.matchStatus == MatchCellStatus.ABONDONED.rawValue{
        self.matchStatusDescriptionLabel.text = vmatch.cancelledReason
        }
        else if vmatch.matchStatus == MatchCellStatus.LIVE.rawValue{
            self.matchStatusDescriptionLabel.text = "On going match"
        }
        else if vmatch.matchStatus == MatchCellStatus.PAST.rawValue{
        self.matchStatusDescriptionLabel.text = "Won"
        }
        else {
            self.matchStatusDescriptionLabel.text = "\(vmatch.matchDay),\(vmatch.matchDate),\(vmatch.matchStartTime)"
        }
        
        self.teamOneNameLabel.text = vmatch.firstTeamName
        self.teamTwoNameLabel.text = vmatch.secondTeamName
        self.teamOneScoreLabel.text = String("\(vmatch.firstTotalScore)/\(vmatch.firstTotalWickets)")
        self.teamTwoScoreLabel.text = String("\(vmatch.secondTotalScore)/\(vmatch.secondTotalWickets)")
        self.teamOneOversLabel.text = String("(\(vmatch.firstTotalOverPlayed).\(vmatch.firstTotalBallsPlayed))")
        self.teamTwoOversLabel.text = String("(\(vmatch.secondTotalOverPlayed).\(vmatch.secondTotalBallsPlayed))")
        
    }
    private func configureMatchStatus(matchStatus: MatchCellStatus) {
        matchStatusLabel.text = " \(matchStatus.rawValue) "
        switch matchStatus {
        case .ABONDONED: matchStatusLabel.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.3176470588, blue: 0.2509803922, alpha: 1); currentMatchStatus = .ABANDONED
        case .LIVE: matchStatusLabel.backgroundColor = #colorLiteral(red: 0.137254902, green: 0.7529411765, blue: 0.3607843137, alpha: 1); currentMatchStatus = .LIVE
        case .PAST: matchStatusLabel.backgroundColor = #colorLiteral(red: 0, green: 0.4588235294, blue: 0.8823529412, alpha: 1); currentMatchStatus = .PAST
        case .UPCOMING: matchStatusLabel.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.662745098, blue: 0, alpha: 1); currentMatchStatus = .UPCOMING
        }
        
    }
}
