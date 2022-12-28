//
//  BowlingHeader.swift
//  demoooo
//
//  Created by Preetam G on 17/12/22.
//

import UIKit

class SimpleLabelHeader: UITableViewHeaderFooterView {
    
    static let identifier = "SimpleLabelHeader"
    static let nibName = "SimpleLabelHeader"
    
    @IBOutlet weak var label: UILabel!
    
    func configureDateLabel(header: String) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: header)
        
        dateFormatter.dateFormat = "EEEE - MMMM d, yyyy"
        
        let formattedDateString = dateFormatter.string(from: date!)
        
        label.text = formattedDateString
    }
    
    func configure(text: String) {
        label.text = text
    }
}
