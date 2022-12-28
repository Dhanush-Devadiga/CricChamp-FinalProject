//
//  CustomRunButton.swift
//  UpdateLiveScore
//
//  Created by Preetam G on 11/12/22.
//

import UIKit

class LiveScoreCustomRunButton: LiveScoreCustomButton {
    
    var zeroButtonColor = #colorLiteral(red: 0.5960784314, green: 0.5960784314, blue: 0.5960784314, alpha: 1)
    var oneButtonColor = #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1)
    var fourSixButtonColor = #colorLiteral(red: 0.3725490196, green: 0.6941176471, blue: 0, alpha: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addRunButtonCornerRadius()
    }
    
    func addRunButtonCornerRadius() {
        self.layer.cornerRadius = self.frame.width / 2
    }
}
