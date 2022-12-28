//
//  ChooseFeilderCell.swift
//  UpdateLiveScore
//
//  Created by Preetam G on 12/12/22.
//

import UIKit

class ChooseFeilderCell: UITableViewCell {
    
    @IBOutlet private weak var playerNameLabel: UILabel!

    func configure(with string: String) {
        playerNameLabel.text = string
    }
}
