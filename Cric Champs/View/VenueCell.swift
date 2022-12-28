//
//  VenueCell.swift
//  ManageViewController
//
//  Created by Dhanush Devadiga on 14/12/22.
//

import UIKit

class VenueCell: UITableViewCell {
    
    @IBOutlet weak var stadiumname: UILabel!
    @IBOutlet weak var city: UILabel!
    
    func setData(data: MatchInformation?) {
        if let data = data {
            self.stadiumname.text = data.groundName
        }
        //self.city.text = "Mangalore"
    }
    
}
