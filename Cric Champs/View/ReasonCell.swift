//
//  ReasonCell.swift
//  UpdateLiveScore
//
//  Created by Preetam G on 15/12/22.
//

import UIKit

class ReasonCell: UITableViewCell {

    static let identifier = "ReasonCell"
    @IBOutlet weak var reasonLabel: UILabel!
    
    func configure(reason: String) {
        reasonLabel.text = reason
    }

}
