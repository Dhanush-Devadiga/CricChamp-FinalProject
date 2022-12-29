//
//  Model.swift
//  ManageViewController
//
//  Created by Dhanush Devadiga on 15/12/22.
//

import Foundation


struct LiveScore {
    var score: [TeamScore]
    var batting: [Batsman]
    var bowling: Bowler?
    var partnership: PartnerShip?
    var fallOfWicket: FallOfWicket?
    var commentary: [Commentary]
    //var recents: [Commentary]
    var inningStatus = false
}
struct MatchScoreBoard {
    var scoreBoard: TeamScoreBoard?
    var extraRuns : ExtraRuns?
    var batting: [Batsman]
    var bowling: [Bowler]
    var fallOfWicket: [FallOfWicket]?
}

struct TeamScore {
    var teamId: Int64
    var teamName: String
    var run: Int
    var over: Int
    var ball: Int
    var wicket: Int
    var currentRunRate: Double
    var requiredRunRate: Double
    var requiredRunsToWin: Int
}

struct TeamScoreBoard {
    var scoreBoardId : Int64
    var tournamentId : Int64
    var matchId : Int64
    var teamId : Int64
    var teamName : String
    var overs : Int
    var ball : Int
    var score : Int
    var totalWicketFall : Int
}

struct Batsman {
    var name: String
    var run: Int
    var ball: Int
    var six: Int
    var four: Int
    var strikeRate: Double
    var isOnStrike: Bool?
    var batsmanStatus : Bool?
    var outByBowler : String?
    var outByPlayer : String?
}

struct Bowler {
    var name: String
    var over: Int
    var ball: Int
    var maiden: Int
    var wicket: Int
    var run: Int
    var economyRate: Double
    var bowlerStatus :Bool?
}

struct PartnerShip {
    var run: Int
    var ball: Int
}

struct FallOfWicket {
    var run: Int
    var wicket: Int
    var ball: Int
    var over: Int
    var playerName : String?
}

struct Commentary {
    var ballStatus: String
    var ball: Int
    var over: Int
    var run: Int
    var overStatus: Bool
    var comment: String
}

struct ExtraRuns {
    var noBall: Int
    var wide: Int
    var legBye: Int
    var bye: Int
    var penaltyRuns: Int
    var totalExtraRuns: Int
}

struct Versus {
    var matchId: Int64
    var teamId: Int64
    var teamName: String
    var isCancelled: Bool
}
