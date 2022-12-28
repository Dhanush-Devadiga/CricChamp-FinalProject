//
//  PlayerScoreCell.swift
//  ManageViewController
//
//  Created by Dhanush Devadiga on 15/12/22.
//

import UIKit

class BatsmanScoreCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var run: UILabel!
    @IBOutlet weak var ball: UILabel!
    @IBOutlet weak var four: UILabel!
    @IBOutlet weak var six: UILabel!
    @IBOutlet weak var strikeRate: UILabel!
    
    func setBatsmanData(batsman: Batsman) {
        if batsman.isOnStrike! {
            self.name.text = batsman.name + "*"
        } else {
            self.name.text = batsman.name
        }
        self.run.text = String(batsman.run)
        self.ball.text = String(batsman.ball)
        self.four.text = String(batsman.four)
        self.six.text = String(batsman.six)
        self.strikeRate .text = String((String(format: "%.2f", batsman.strikeRate)))
    }
    
    func setDefaultData() {
        self.run.text = "-"
        self.ball.text = "-"
        self.four.text = "-"
        self.six.text = "-"
        self.strikeRate.text = "-"
    }
}
