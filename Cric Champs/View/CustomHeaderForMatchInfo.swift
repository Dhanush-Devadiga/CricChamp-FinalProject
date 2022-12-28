//
//  CustomHeaderForMatchInfo.swift
//  Cric Champs
//
//  Created by Dhanush Devadiga on 28/12/22.
//

import Foundation
import UIKit
 
class CustomHeader: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }

    func getHeadetTitle(frame: CGRect, text: String) -> UILabel {
        let label = UILabel()
        label.frame = CGRect.init(x: 15, y: 5, width: frame.width-10, height: frame.height-10)
        label.text = text
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }

}
