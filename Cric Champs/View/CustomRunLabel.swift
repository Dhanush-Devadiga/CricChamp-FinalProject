//
//  CustomRunLabel.swift
//  ManageViewController
//
//  Created by Dhanush Devadiga on 13/12/22.
//

import Foundation
import UIKit

class CustomRunLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.width / 2
    }
    
    func setData(run: String) {
        switch run {
        case "0" :  self.text = "0"
                    self.textColor = .black
                    self.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
            
        case "1" :  self.text = "1"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1)

        case "2" :  self.text = "2"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1)

        case "3" :  self.text = "3"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1)

        case "4" :  self.text = "4"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.3725490196, green: 0.6941176471, blue: 0, alpha: 1)
            
        case "6" :  self.text = "6"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.5921568627, green: 0.168627451, blue: 0.8784313725, alpha: 1)
            
        case "W" :  self.text = "W"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.3176470588, blue: 0.2509803922, alpha: 1)
            
        case "Wd" : self.text = "Wd"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.431372549, blue: 0.2941176471, alpha: 1)
            
        case "Wd1": self.text = "Wd1"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.431372549, blue: 0.2941176471, alpha: 1)
            
        case "Wd2": self.text = "Wd2"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.431372549, blue: 0.2941176471, alpha: 1)
            
        case "Wd3": self.text = "Wd3"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.431372549, blue: 0.2941176471, alpha: 1)
            
        case "Nb":  self.text = "Nb"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.431372549, blue: 0.2941176471, alpha: 1)
            
        case "Nb1": self.text = "Nb1"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.431372549, blue: 0.2941176471, alpha: 1)

        case "Nb2": self.text = "Nb2"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.431372549, blue: 0.2941176471, alpha: 1)
            
        case "Nb3": self.text = "Nb3"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.431372549, blue: 0.2941176471, alpha: 1)
            
        case "Nb4": self.text = "Nb4"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.431372549, blue: 0.2941176471, alpha: 1)
            
        case "Nb6": self.text = "Nb6"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.431372549, blue: 0.2941176471, alpha: 1)
            
        case "B1":  self.text = "B1"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.431372549, blue: 0.2941176471, alpha: 1)
            
        case "B2":  self.text = "B2"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.431372549, blue: 0.2941176471, alpha: 1)

        case "B3":  self.text = "B3"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.431372549, blue: 0.2941176471, alpha: 1)
            
        case "B4":  self.text = "B4"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.431372549, blue: 0.2941176471, alpha: 1)
            
        case "B5":  self.text = "B5"
                    self.textColor = .white
                    self.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.431372549, blue: 0.2941176471, alpha: 1)
            
        case ".":   self.text = "."
                    self.textColor = .black
                    self.font = UIFont.systemFont(ofSize: 18)
                    self.backgroundColor = .clear
            
        case "|":   self.text = "|"
                    self.textColor = .black
                    self.font = UIFont.systemFont(ofSize: 18)
                    self.backgroundColor = .clear
            
        default:    self.text = "_"
                    self.textColor = .white
                    self.backgroundColor = .clear
        }

    }
    
}

