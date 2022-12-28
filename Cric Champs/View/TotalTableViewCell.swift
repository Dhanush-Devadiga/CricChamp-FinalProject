//
//  TotalTableViewCell.swift
//  ScoreBoard
//
//  Created by Prajwal Rao Kadam on 12/12/22.
//

import UIKit

class TotalTableViewCell: UITableViewCell {

    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var score: UILabel!

    func setData(data: Int) {
        score.text = String(data)
    }
}
