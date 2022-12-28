//
//  RecentBallStatusCell.swift
//  ManageViewController
//
//  Created by Dhanush Devadiga on 16/12/22.
//

import UIKit

class RecentBallStatusCell: UICollectionViewCell {
    
    @IBOutlet weak var status: CustomRunLabel!
    
    func setRecentBallStatus(ballStatus: String, run : Int) {
        let status = self.checkBallStatus(status: ballStatus, run: run)
        self.status.setData(run: status)
    }
    
    private func checkBallStatus(status: String, run: Int) -> String {
        switch status {
        case BallStatus.wide.rawValue: if run == 0 {
            return "Wd"
        } else {
            return "Wd" + String(run)
        }
        
        case BallStatus.noBall.rawValue: if run == 0 {
            return "Nb"
        } else {
            return "Nb" + String(run)
        }
        
        case BallStatus.bye.rawValue: if run == 0 {
            return "B"
        } else {
            return "B" + String(run)
        }
        case BallStatus.wicket.rawValue: return "W"
        
        case BallStatus.zero.rawValue: return "."
            
        default:
            return status
        }
    }
}
