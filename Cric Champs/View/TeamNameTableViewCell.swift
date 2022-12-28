//
//  TeamNameTableViewCell.swift
//  ScoreBoard
//
//  Created by Vinayaka V on 13/12/22.
//

import UIKit



class TeamNameTableViewCell: UITableViewCell {

    @IBOutlet weak var teamsName: UILabel!
    

    func setTeamName(data: Versus ) {
        teamsName.text = data.teamName
    }

 
}
