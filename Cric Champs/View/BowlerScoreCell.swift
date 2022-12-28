//
//  BowlerScoreCell.swift
//  ManageViewController
//
//  Created by Dhanush Devadiga on 15/12/22.
//

import UIKit

class BowlerScoreCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var over: UILabel!
    @IBOutlet weak var maiden: UILabel!
    @IBOutlet weak var run: UILabel!
    @IBOutlet weak var wicket: UILabel!
    @IBOutlet weak var economyRate: UILabel!
    
    func setBowlerData(bowler: Bowler?) {
        
        if let bowler = bowler {
            self.run.text = String(bowler.run)
            self.name.text = bowler.name
            self.over.text = String(bowler.over) + "." + String(bowler.ball)
            self.economyRate .text = String((String(format: "%.2f", bowler.economyRate)))
            self.maiden.text = String(bowler.maiden)
            self.wicket.text = String(bowler.wicket)
        }
        
    }
}
