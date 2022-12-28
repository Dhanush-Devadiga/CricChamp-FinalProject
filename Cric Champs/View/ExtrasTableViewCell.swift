//
//  ExtrasTableViewCell.swift
//  ScoreBoard
//
//  Created by Prajwal Rao Kadam on 12/12/22.
//

import UIKit

class ExtrasTableViewCell: UITableViewCell {

    @IBOutlet weak var extras: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var everyExtraRuns: UILabel!
    
    func setExtraScoreData(extraRun : ExtraRuns?)
    {
        if let extraRun = extraRun {
            score.text = String(extraRun.totalExtraRuns)
            let bye = "b" + String(extraRun.bye) + ", "
            let noBall = "nb" + String(extraRun.noBall) + ", "
            let wide = "w" + String(extraRun.wide) + ", "
            let legBye = "lb" + String(extraRun.legBye) + ", "
            let penaltyRuns = "p" + String(extraRun.penaltyRuns)
            everyExtraRuns.text = "(" + bye + noBall + wide + legBye + penaltyRuns + ")"
        }
    }

}
