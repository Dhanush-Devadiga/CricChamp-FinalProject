//
//  InfoTableViewCell.swift
//  ManageViewController
//
//  Created by Dhanush Devadiga on 14/12/22.
//

import UIKit

class MatchInfoCell: UITableViewCell {
    
    @IBOutlet weak var matchNumber: UILabel!
    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var umpireName: UILabel!
    @IBOutlet weak var matchStartTime: UILabel!
    @IBOutlet weak var matchDay: UILabel!
    
    func setData(data: MatchInformation?) {
        if let data = data {
            matchNumber.text = String(data.matchNumber)
            matchDate.text = data.matchDate
            umpireName.text = data.umpireName
            matchStartTime.text = data.matchStartTime
            matchDay.text = data.matchDay
        }
    }
       
    
}
