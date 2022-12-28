//
//  CustomButton.swift
//  UpdateLiveScore
//
//  Created by Preetam G on 11/12/22.
//

import UIKit

class LiveScoreCustomButton: UIButton {
    
    let extraButtonColor = #colorLiteral(red: 1, green: 0.4901960784, blue: 0, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addBorder()
    }
    func configure() {
        self.setTitleColor(UIColor(cgColor: self.layer.borderColor!), for: .normal)
    }
    
    func addBorder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = self.titleColor(for: .normal)?.cgColor
    }

    func setRadioButtons(button: LiveScoreCustomButton, buttons: [LiveScoreCustomButton]) {
        for radioButton in buttons {
            if radioButton !== button {
                radioButton.deselectButton()
            }
        }
        button.selectButton()
    }
    
    func changeButtonsStatus(sender: LiveScoreCustomButton, buttons: [LiveScoreCustomButton]) {
        setRadioButtons(button: self, buttons: buttons)
    }
    
    func selectButton() {
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = UIColor(cgColor: self.layer.borderColor!)
    }
    
    func deselectButton() {
        configure()
        self.backgroundColor = .clear
    }
}
