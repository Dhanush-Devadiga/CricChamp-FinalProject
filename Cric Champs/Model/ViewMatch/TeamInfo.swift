//
//  Team.swift
//  demoooo
//
//  Created by Preetam G on 18/12/22.
//

import UIKit

struct TeamInfo {
    let teamId: Int64
    let tournamentId: Int64
    let teamName: String
    let captainName: String
    let city: String
    let numberOfPlayers: Int
    let totalMatchesPlayed: Int
    let totalWins: Int
    let totalLosses: Int
    let totalDrawOrCancelledOrNoResult: Int
    let points: Int
    let teamHighestScore: Int
    let netRunRate: Double
    let teamLogo: String
    let teamStatus: String?
    let isDeleted: Bool
}
