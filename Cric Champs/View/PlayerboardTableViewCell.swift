//
//  PlayerboardTableViewCell.swift
//  ScoreBoard
//
//  Created by Prajwal Rao Kadam on 12/12/22.
//

import UIKit

class PlayerboardTableViewCell: UITableViewCell {

    @IBOutlet weak var batsManName: UILabel!
    @IBOutlet weak var bowlerName: UILabel!
    @IBOutlet weak var run: UILabel!
    @IBOutlet weak var ballsFaced: UILabel!
    @IBOutlet weak var fours: UILabel!
    @IBOutlet weak var sixes: UILabel!
    @IBOutlet weak var strikeRate: UILabel!

    
    func setPlayerData(batsManData : Batsman)
    {
        run.text = String(batsManData.run)
        ballsFaced.text = String(batsManData.ball)
        fours.text = String(batsManData.four)
        sixes.text = String(batsManData.six)
        strikeRate.text = String(batsManData.strikeRate)
        batsManName.text = batsManData.name
        if let status = batsManData.isOnStrike, status == true {
            batsManName.textColor = #colorLiteral(red: 0.3725490196, green: 0.6941176471, blue: 0, alpha: 1)
        } else {
            batsManName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        if let outStatus = batsManData.batsmanStatus, outStatus == true {
            bowlerName.text = "Not Out"
        } else {
            guard let bowler = batsManData.outByBowler else {
                return
            }
            guard let fielder = batsManData.outByPlayer else {
                return
            }
            if fielder == "" {
                bowlerName.text = "b " + bowler
            } else {
                bowlerName.text = "c " + fielder + " b " + bowler
            }
        }
    }
    
}
