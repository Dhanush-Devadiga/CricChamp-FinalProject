//
//  UpdateLiveModel.swift
//  UpdateLiveScore
//
//  Created by Preetam G on 19/12/22.
//

import Foundation


struct Extra {
    var extraStatus: Bool = false
    var extraType: String = ExtraType.wide.rawValue
}

struct Wicket {
    var wicketStatus: Bool = false
    var outType: String = WicketType.STUMPED.rawValue
    var outPlayerID: Int
    var fielderID: Int
    var newBatsmanID: Int
}

struct Match {
    var tournamentID: Int
    var matchID: Int
    var battingTeamID: Int
    var bowlingTeamID: Int
    var strikeBatsmanID: Int
    var noStrikeBatsmanID: Int
    var bowlerID: Int
    var over: Int
    var runs: Int
    var matchStatus: String = MatchStatus.FIRSTINNING.rawValue
}

struct PlayerStruct: Hashable {
    var playerId: Int
    var playerName: String
}

enum ExtraType: String {
    case wide, bye, noBall, legBye, penaltyRuns
}

enum WicketType: String {
    case HITWICKET, STUMPED, CAUGHT, RUNOUT, LBW, BOWLED, OTHERS
}

enum MatchStatus: String {
    case ABANDONED, PAST, LIVE, UPCOMING, BYE, INNINGCOMPLETED, CANCELLED, FIRSTINNING,SECONDINNING, INPROGRESS, COMPLETED
}

enum TournamentType {
    case LEAGUE, KNOCKOUT, INDIVIDUALMATCH
}
