//
//  CustomWicketButton.swift
//  UpdateLiveScore
//
//  Created by Preetam G on 11/12/22.
//

import UIKit

class CustomWicketButton: LiveScoreCustomButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addWicketButtonCornerRadius()
    }
    
    
    func addWicketButtonCornerRadius() {
        self.layer.cornerRadius = 20
    }

}
