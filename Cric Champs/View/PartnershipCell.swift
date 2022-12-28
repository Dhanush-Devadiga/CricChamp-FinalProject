//
//  PartnershipCell.swift
//  ManageViewController
//
//  Created by Dhanush Devadiga on 15/12/22.
//

import UIKit

class PartnershipCell: UITableViewCell {


    @IBOutlet weak var fallOfWicket: UILabel!
    @IBOutlet weak var run: UILabel!
    @IBOutlet weak var ball: UILabel!
    @IBOutlet weak var over: UILabel!
    @IBOutlet weak var fallOfWicketTitle: UILabel!
    
    func setPartnershipData(partnership: PartnerShip?, fallOfWicket: FallOfWicket?) {
        guard  let partnershipData = partnership else {
            return
        }
        self.run.text = String(partnershipData.run) + " Runs"
        self.ball.text = "(" + String(partnershipData.ball) + " balls" + ")"
        guard  let fallOfWicketData = fallOfWicket else {
            self.fallOfWicket.isHidden = true
            self.over.isHidden = true
            self.fallOfWicketTitle.isHidden = true
            return
        }
        self.fallOfWicket.isHidden = false
        self.over.isHidden = false
        self.fallOfWicketTitle.isHidden = false
        self.fallOfWicket.text = String(fallOfWicketData.run) + "/" + String(fallOfWicketData.wicket)
        self.over.text = "(" + String(fallOfWicketData.over) + "." + String(fallOfWicketData.ball) + ")"
    }
}
