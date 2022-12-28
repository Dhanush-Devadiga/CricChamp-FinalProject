//
//  CommentaryCell.swift
//  ManageViewController
//
//  Created by Dhanush Devadiga on 15/12/22.
//

import UIKit
enum BallStatus: String {
    case wide = "wide"
    case noBall = "noBall"
    case bye = "bye"
    case zero = "0"
    case wicket = "WICKET"
    case over = "|"
}

class CommentaryCell: UITableViewCell {

    @IBOutlet weak var currentball: UILabel!
    @IBOutlet weak var run: CustomRunLabel!
    @IBOutlet weak var comment: UILabel!
    
    func setCommentary(commentary: Commentary) {
        self.currentball.text = String(commentary.over) + "." + String(commentary.ball)
        self.comment.text = commentary.comment
        let status = self.checkBallStatus(status: commentary.ballStatus, run: commentary.run)
        self.run.setData(run: status)
    }
    
    private func checkBallStatus(status: String, run: Int) -> String {
        switch status {
        case BallStatus.wide.rawValue: if run == 0 {
            return "Wd"
        } else {
            return "Wd" + String(run)
        }
        
        case BallStatus.noBall.rawValue: if run == 0 {
            return "Nb"
        } else {
            return "Nb" + String(run)
        }
        
        case BallStatus.bye.rawValue: if run == 0 {
            return "B"
        } else {
            return "B" + String(run)
        }
        case BallStatus.wicket.rawValue: return "W"
        default:
            return status
        }
    }
}

