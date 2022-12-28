//
//  Match.swift
//  ManageSegmentCricChamps
//
//  Created by Preetam G on 22/12/22.
//

import Foundation
struct MatchCell {
    
    var date: String
    var matchNumber: String
    var groundNumber: String
    var teamOneName: String
    var teamTwoName: String
    
    var matchStatus: MatchCellStatus = .UPCOMING
    var teamOneScore: String
    var teamTwoScore: String
    var teamOneOvers: String
    var teamTwoOvers: String
    var matchResultDescription: String
}
