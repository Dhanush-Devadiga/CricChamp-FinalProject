//
//  CoAdminCell.swift
//  ManageSegmentCricChamps
//
//  Created by Preetam G on 22/12/22.
//

import UIKit

class CoAdminCell: UITableViewCell {

    static let identifier = "CoAdminCell"
    static let nibName = "CoAdminCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var matchesLabel: UILabel!
    @IBOutlet weak var currentMatchLabel: UILabel!
    var prevlabel: UILabel?
    
    func configureCell(name: String, profilePhoto: UIImage?, matchList: String, currentMatch: String) {
        nameLabel.text = name
        if let photo = profilePhoto {
            profileImage.image = photo
        } else {
            profileImage.image = #imageLiteral(resourceName: "profile2")
        }
        
        matchesLabel.text = matchList
        currentMatchLabel.text = "\(currentMatch) in progress"
    }
    
}
