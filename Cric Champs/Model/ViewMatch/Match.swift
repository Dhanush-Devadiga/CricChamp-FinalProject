//
//  CricketMatch.swift
//  demoooo
//
//  Created by Preetam G on 18/12/22.
//

import Foundation

struct MatchData {
    let matches: [viewMatch]
    let versus: [VTeams]
}

struct viewMatch {
    let matchId: Int64
    let tournamentId: Int64
    let groundId: Int64
    let groundName: String
    let umpireId: Int64
    let umpireName: String
    let roundNumber: Int
    let matchNumber: Int
    let matchStatus: String
    let matchDate: String
    let matchDay: String
    let matchStartTime: String
    let matchEndTime: String
    let totalNumberOfWicket: Int
    let isCancelled: String?
    let cancelledReason: String
}

struct VTeams {
    let matchId: Int64
    let teamId: Int64
    let teamName: String
    let totalScore: Int
    let totalWickets: Int
    let totalOverPlayed: Int
    let totalBallsPlayed: Int
    let matchResult: String?
    let isCancelled: String
}

enum MatchCellStatus: String {
    case ABONDONED
    case PAST
    case LIVE
    case UPCOMING
}

struct MatchInformation {
    var tournamentId: Int64
    var matchId: Int64
    var matchNumber: Int
    var teamOne: String
    var teamTwo: String
    var teamOneId: Int64
    var teamTwoId: Int64
    var groundName: String
    var matchDate: String
    var matchDay: String
    var matchStartTime: String
    var umpireName: String
}

struct MatchInfo {
    let tournamentId: Int64
    let matchId: Int64
    let groundId: Int64?
    let groundName: String
    let matchStatus: String
    let matchDate: String
    let matchDay: String
    let matchStartTime: String
    let matchEndTime: String
    let firstTeamId: Int64
    let firstTeamName: String
    let firstTotalScore: Int
    let firstTotalWickets: Int
    let firstTotalOverPlayed: Int
    let firstTotalBallsPlayed: Int
    let firstTeamMatchResult: String
    let secondTeamId: Int64
    let secondTeamName: String
    let secondTotalScore: Int
    let secondTotalWickets: Int
    let secondTotalOverPlayed: Int
    let secondTotalBallsPlayed: Int
    let secondTeamMatchResult: String?
    let cancelledReason: String?
}
