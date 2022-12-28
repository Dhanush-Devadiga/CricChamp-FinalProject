//
//  TeamScoreHeaderView.swift
//  ManageViewController
//
//  Created by Dhanush Devadiga on 15/12/22.
//

import UIKit

class TeamScoreHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var over: UILabel!
    
    func setData(team: TeamScore) {
        let score = String(team.run) + "/" + String(team.wicket)
        let over = String(team.over) + "." + String(team.ball)
        
        self.name.text = team.teamName
        self.score.text = score
        self.over.text = "(" + over + ")"

    }
    
    func setDefaultValue() {
        self.name.text = ""
        self.score.text = "- -"
        self.over.text = ""

    }
}
