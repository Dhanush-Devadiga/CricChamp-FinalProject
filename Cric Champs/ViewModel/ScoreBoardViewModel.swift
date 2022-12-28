//
//  ScoreBoardViewModel.swift
//  LiveScoreProject
//
//  Created by Dhanush Devadiga on 17/12/22.
//

import Foundation

class ScoreBoardViewModel {
    var network = NetworkManager()
    static var shared = ScoreBoardViewModel()
    var liveScore = LiveScoreViweMdoel.shared
    var parameterForScoreBoard:[String: String] = [:]
    var scoreBoard: MatchScoreBoard?
    
    func makeDataRequest(parameters: [String: Any], completion: @escaping (MatchScoreBoard?, Error?) -> Void) {
        //setparameterForScoreBoard()
        let url = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/scoreboard/view-all"
        let queryUrl = URL(string: url)
        if queryUrl != nil { network.getData(url: url, parameters: parameters, headers: nil, image: nil){ apidata, error in
            if let data = apidata as? [String: Any] {
                //print("DATA", data)
                let scoreboard = self.fetchRequiredScoreBoardData(data: data)
                self.scoreBoard = scoreboard
                completion(scoreboard, nil)
            } else {
                print(error?.localizedDescription as Any)
            }
        }
        }
    }
    
    private func setparameterForScoreBoard() {
        if let data = liveScore.currentMatchInfo {
            parameterForScoreBoard["tournamentId"] = String(data.tournamentId)
            parameterForScoreBoard["matchId"] = String(data.matchId)
            
        }
    }
    func fetchRequiredScoreBoardData(data: [String: Any]) -> MatchScoreBoard {
        var teamScoreBoard: TeamScoreBoard?
        var extraRuns : ExtraRuns?
        var batting = [Batsman]()
        var bowling = [Bowler]()
        var fallOfWickets = [FallOfWicket]()
        
        if let scoreBoardData = data["scoreBoard"] as? [String: Any] {
            teamScoreBoard = fetchScoreBoardData(data: scoreBoardData)
        }
        
        if let extraRu = data["extraRuns"] as? [String:Any ]{
            extraRuns = fetchExtraRunData(data: extraRu)
        }
        
        if let batsmans = data["batsmanSB"] as? ([Any]) {
            for index in 0..<batsmans.count {
                if let battingData = batsmans[index] as? [String: Any] {
                    batting.append(fetchBattingData(data: battingData))
                }
            }
        }

        if let bowl = data["bowlerSB"] as? ([Any]) {
            for index in 0..<bowl.count {
                if let bowlingData = bowl[index] as? [String: Any] {
                    bowling.append(fetchBowlingData(data: bowlingData))
                }
            }
        }

        if let fallOfWicket = data["fallOfWicketSB"] as? ([Any]) {
            for index in 0..<fallOfWicket.count {
                if let fallOfWicketData = fallOfWicket[index] as? [String: Any] {
                    fallOfWickets.append(fetchfallOfWicketData(data: fallOfWicketData))
                }
            }
        }
//
//        if let versusData = data["versus"] as? [(Any)] {
//            for index in 0..<versusData.count {
//                if let data = versusData[index] as? [String: Any] {
//                    versus.append(fetchVersusData(data: data))
//                }
//
//            }
//        }
        let scoresBoards = MatchScoreBoard(scoreBoard: teamScoreBoard, extraRuns : extraRuns, batting: batting, bowling: bowling, fallOfWicket: fallOfWickets)
        
        return scoresBoards
    }
    
    func fetchScoreBoardData(data: [String: Any]) -> TeamScoreBoard {
        var scoreBoardId = Int64(0)
        var tournamentId = Int64(0)
        var matchId = Int64(0)
        var teamId = Int64(0)
        var teamName = ""
        var overs = 0
        var ball = 0
        var score = 0
        var totalWicketFall = 0
        
        if let id = data["scoreBoardId"] as? Int64 {
            scoreBoardId = id
        }
        
        if let id = data["tournamentId"] as? Int64 {
            tournamentId = id
        }
        
        if let id = data["matchId"] as? Int64 {
            matchId = id
        }
        if let id = data["teamId"] as? Int64 {
            teamId = id
        }
        if let name = data["teamName"] as? String {
            teamName = name
        }
        if let over = data["overs"] as? Int {
            overs = over
        }
        if let balls = data["ball"] as? Int {
            ball = balls
        }
        if let scores = data["score"] as? Int {
            score = scores
        }
        if let wicket = data["totalWicketFall"] as? Int {
            totalWicketFall = wicket
        }
        
        let teamscoreBoard = TeamScoreBoard(scoreBoardId: scoreBoardId, tournamentId: tournamentId, matchId: matchId, teamId: teamId, teamName: teamName, overs: overs, ball: ball, score: score, totalWicketFall: totalWicketFall)
        return teamscoreBoard
    }
    
    func fetchExtraRunData(data: [String: Any]) -> ExtraRuns
    {
        var numberOfNoBall = 0
        var numberOfWide = 0
        var numberOfLegBye = 0
        var numberOfBye = 0
        var totalPenaltyRuns = 0
        var totalExtraRuns = 0
        
        if let noball = data["noBall"] as? Int {
            numberOfNoBall = noball
        }
        if let wide = data["wide"] as? Int {
            numberOfWide = wide
        }
        if let legBye = data["legBye"] as? Int {
            numberOfLegBye = legBye
        }
        if let bye = data["bye"] as? Int {
            numberOfBye = bye
        }
        if let penaltyRuns = data["penaltyRuns"] as? Int {
            totalPenaltyRuns = penaltyRuns
        }
        if let extraRuns = data["totalExtraRuns"] as? Int {
            totalExtraRuns = extraRuns
        }
        
        let extraRuns = ExtraRuns(noBall: numberOfNoBall, wide: numberOfWide, legBye: numberOfLegBye, bye: numberOfBye, penaltyRuns: totalPenaltyRuns, totalExtraRuns: totalExtraRuns)
        
        return extraRuns
    }
    
    func fetchBattingData(data: [String: Any]) -> Batsman {
        var playerName = ""
        var runs = 0
        var balls = 0
        var fours = 0
        var sixes = 0
        var strikeRate = 0.0
        var batsmanStatus =  false
        var outByBowler = ""
        var outByPlayer = ""
        var isOnStrike = false
        
        if let name = data["playerName"] as? String {
            playerName = name
        }
        if let run = data["runs"] as? Int {
            runs = run
        }
        if let ball = data["balls"] as? Int {
            balls = ball
        }
        if let four = data["fours"] as? Int {
            fours = four
        }
        if let six = data["sixes"] as? Int {
            sixes = six
        }
        if let strikerate = data["strikeRate"] as? Double {
            strikeRate = strikerate
        }
        if let status = data["batsmanStatus"] as? String {
            if status == "NOTOUT" {
                batsmanStatus = true
            }
        }
        if let outBy = data["outByStatus"] as? String {
            outByBowler = outBy
        }
        if let outBy = data["outByPlayer"] as? String {
            outByPlayer = outBy
        }
        
        if let status = data["strikePosition"] as? String{
            if status == "STRIKE"{
                isOnStrike = true
            }
        }

        let batsman = Batsman(name: playerName, run: runs, ball: balls, six: sixes, four: fours, strikeRate: strikeRate, isOnStrike: isOnStrike, batsmanStatus: batsmanStatus, outByBowler: outByBowler, outByPlayer: outByPlayer)
        return batsman
    }
    
    func fetchBowlingData(data: [String: Any] ) -> Bowler {

        var playerName = ""
        var runs = 0
        var overs = 0
        var balls = 0
        var maidenOvers = 0
        var wickets = 0
        var economyRate = 0.0
        var bowlerStatus = false
        
        if let name = data["playerName"] as? String {
            playerName = name
        }
        if let run = data["runs"] as? Int {
            runs = run
        }
        if let over = data["overs"] as? Int {
            overs = over
        }
        if let ball = data["balls"] as? Int {
            balls = ball
        }
        if let maidenOver = data["maidenOvers"] as? Int {
            maidenOvers = maidenOver
        }
        if let wicket = data["wickets"] as? Int {
            wickets = wicket
        }
        if let economyrate = data["economyRate"] as? Double {
            economyRate = economyrate
        }
        if let status = data["bowlerStatus"] as? String {
            if status == "BOWLING" {
                bowlerStatus = true
            }
        }
        
        let bowler = Bowler(name: playerName, over: overs, ball: balls, maiden: maidenOvers, wicket: wickets, run: runs, economyRate: economyRate, bowlerStatus: bowlerStatus)
        return bowler
   
    }
    
    func fetchfallOfWicketData(data: [String: Any]) -> FallOfWicket {
        var playerName = ""
        var score = 0
        var wicketNumber = 0
        var balls = 0
        var overs = 0
        
        if let name = data["playerName"] as? String {
            playerName = name
        }
        if let run = data["score"] as? Int {
            score = run
        }
        if let wicket = data["wicketNumber"] as? Int {
            wicketNumber = wicket
        }
        if let over = data["overs"] as? Int {
            overs = over
        }
        if let ball = data["ball"] as? Int {
            balls = ball
        }
        let fallOfWicket = FallOfWicket(run: score, wicket: wicketNumber, ball: balls, over: overs, playerName: playerName)
        return fallOfWicket
    }
    
//    func fetchVersusData(data: [String: Any]) -> Versus {
//        var matchId = Int64(0)
//        var teamId = Int64(0)
//        var teamName = ""
//        var isCancelled = false
//
//        if let id = data["matchId"] as? Int64 {
//            matchId = id
//        }
//        if let id = data["teamId"] as? Int64 {
//            teamId = id
//        }
//        if let name = data["teamName"] as? String {
//            teamName = name
//        }
//        if let matchStatus = data["isCancelled"] as? Bool {
//            isCancelled = matchStatus
//        }
//        let versus = Versus(matchId: matchId, teamId: teamId, teamName: teamName, isCancelled: isCancelled)
//        return versus
//    }
//
    
}
