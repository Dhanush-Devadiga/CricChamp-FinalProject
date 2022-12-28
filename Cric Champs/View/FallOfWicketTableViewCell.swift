//
//  FallOfWicketTableViewCell.swift
//  ScoreBoard
//
//  Created by Prajwal Rao Kadam on 14/12/22.
//

import UIKit

class FallOfWicketTableViewCell: UITableViewCell {

    @IBOutlet weak var fallOfWickets: UILabel!
    
    func setFallOfWicketData(data: [FallOfWicket]) {
        var fallOfWicketData = ""
        for index in 0..<data.count {
            fallOfWicketData += formattedString(data: data[index])
            if index != data.count - 1{
                fallOfWicketData += ", "
            }
        }
        fallOfWickets.text = fallOfWicketData
    }
    
    private func formattedString(data: FallOfWicket) -> String {
        let over = String(data.over) + "." + String(data.ball)
        let bowler = "(" + data.playerName! + ", " + over + ")"
        let result = String(data.run) + "/" + String(data.wicket) + bowler
        return result
    }

   
}
