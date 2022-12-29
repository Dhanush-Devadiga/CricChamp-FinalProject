//
//  LiveScoreViewModel.swift
//  ManageViewController
//
//  Created by Dhanush Devadiga on 14/12/22.
//

import Foundation


class LiveScoreViweMdoel {
    var network = NetworkManager()
    static var shared = LiveScoreViweMdoel()
    
    var parametersForLiveMatchScore = ["tournamentId" : "1", "matchId": "1"]
    var parametersForGetMatchInfo = ["tournamentId" : "",  "matchId": ""]
    var currentTournamentId: Int64?
    var currentMatchId: Int64?
    var currentMatchInfo: MatchInformation?
    var isUpCommingMatch = false
    var liveScore: LiveScore?
    var versus = [Versus]()

    func makeDataRequest(completion: @escaping (LiveScore?, Error?) -> Void) {
        setParameterForLiveMatchScore()
        let url = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/live/view-all"
        let queryUrl = URL(string: url)
        if queryUrl != nil { network.getData(url: url, parameters: parametersForLiveMatchScore, headers: nil, image: nil){ apidata, error in
            if let data = apidata as? [String: Any] {
                let score = self.fetchRequiredLiveScoreData(data: data)
                self.liveScore = score
                completion(score, nil)
            } else {
                print(error?.localizedDescription as Any)
            }
        }
        }
    }
    
    private func setParameterForLiveMatchScore(){
        if let data = currentMatchInfo {
            parametersForLiveMatchScore["tournamentId"] = String(data.tournamentId)
            parametersForLiveMatchScore["matchId"] = String(data.matchId)
        }
    }
    
    
    func fetchRequiredLiveScoreData(data: [String: Any]) -> LiveScore {
        var bowler: Bowler?
        var partnership: PartnerShip?
        var allBatsman = [Batsman]()
        var teamLiveScore = [TeamScore]()
        var commentary = [Commentary]()
        var fallOfWicket: FallOfWicket?
        var inningStatus = false
        
        if let score = data["lives"] as? ([Any]) {
            for index in 0..<score.count {
                if let scoreData = score[index] as? [String: Any] {
                    teamLiveScore.append(fetchLiveScoreData(data: scoreData))
                }
            }
        }
        
        if let bowlerData = data["bowlerSB"] as? [String: Any] {
            bowler = fetchLiveBowlerData(data: bowlerData)
        }
        
        if let partnershipData = data["partnership"] as? [String: Any] {
            partnership = fetchLivePartnershipData(data: partnershipData)
        }
        
        if let fallOfWickets = data["fallOfWicketSB"] as? [String: Any] {
            fallOfWicket = fetchLiveFallOfWicketData(data: fallOfWickets)
        }
        
        if let batsmanData = data["batsmanSB"] as? ([Any]) {
            for index in 0..<batsmanData.count {
                if let batsmanData = batsmanData[index] as? [String: Any] {
                    allBatsman.append(fetchLiveBatsmanData(data: batsmanData))
                }
            }
        }
        
        if let commentry = data["commentary"] as? ([Any]) {
            for index in 0..<commentry.count {
                if let commentaryData = commentry[index] as? [String: Any] {
                    let fetchedCommentary = fetchLiveCommentary(data: commentaryData)
                    if fetchedCommentary.overStatus {
                        commentary.append(Commentary(ballStatus: "|", ball: 0, over: fetchedCommentary.over + 1, run: 68, overStatus: true, comment: ""))
                    }
                    commentary.append(fetchedCommentary)
                }
            }
        }
        
        if let status = data["matchStatus"] as? String {
            if status == MatchStatus.INNINGCOMPLETED.rawValue {
                inningStatus = true
            }
        }

        let liveScore = LiveScore(score: teamLiveScore, batting: allBatsman, bowling: bowler, partnership: partnership, fallOfWicket: fallOfWicket, commentary: commentary, inningStatus: inningStatus)
        return liveScore
    }
    
    func fetchLiveScoreData(data: [String: Any]) -> TeamScore {
        var teamId = Int64(0)
        var teamName = ""
        var over = 0
        var run = 0
        var ball = 0
        var wicket = 0
        var currentRunRate = 0.0
        var requiredRunRate = 0.0
        var requiredRunsToWin = 0
        
        if let id = data["teamId"] as? Int64 {
            teamId = id
        }
        
        if let name = data["teamName"] as? String {
            teamName = name
        }
        if let overs = data["overs"] as? Int {
            over = overs
        }
        if let balls = data["balls"] as? Int {
            ball = balls
        }
        if let runs = data["runs"] as? Int {
            run = runs
        }
        if let wickets = data["wickets"] as? Int {
            wicket = wickets
        }
        if let reqRunRate = data["requiredRunRate"] as? Double {
            requiredRunRate = reqRunRate
        }
        if let curRunRate = data["currentRunRate"] as? Double {
            currentRunRate = curRunRate
        }
        if let runsNeeded = data["runsNeeded"] as? Int {
            requiredRunsToWin = runsNeeded
        }
        
        let score = TeamScore(teamId: teamId, teamName: teamName, run: run, over: over, ball: ball, wicket: wicket, currentRunRate: currentRunRate, requiredRunRate: requiredRunRate, requiredRunsToWin: requiredRunsToWin)
        return score
    }
    
    func fetchLiveBatsmanData(data: [String: Any]) -> Batsman {
        
        var batsman = Batsman(name: "", run: 0, ball: 0, six: 0, four: 0, strikeRate: 0.0, isOnStrike: false, batsmanStatus: nil, outByBowler: nil, outByPlayer: nil)
        
        if let playerName = data["playerName"] as? String {
            batsman.name = playerName
        }
        if let balls = data["balls"] as? Int {
            batsman.ball = balls
        }
        if let runs = data["runs"] as? Int {
            batsman.run = runs
        }
        if let fours = data["fours"] as? Int {
            batsman.four = fours
        }
        if let sixes = data["sixes"] as? Int {
            batsman.six = sixes
        }
        if let stkRate = data["strikeRate"] as? Double {
            batsman.strikeRate = stkRate
        }
        if let onStrike = data["strikePosition"] as? String {
            if onStrike == "STRIKE" {
                batsman.isOnStrike = true
            }
        }

        return batsman
    }
    
    func fetchLiveBowlerData(data: [String: Any]) -> Bowler {
        var over = 0
        var maidenOver = 0
        var wicket = 0
        var run = 0
        var economyRate = 0.0
        var name = ""
        var ball = 0
        
        if let totalOver = data["overs"] as? Int {
            over = totalOver
        }
        if let totalBall = data["balls"] as? Int {
            ball = totalBall
        }
        if let totalWicket = data["wickets"] as? Int {
            wicket = totalWicket
        }
        if let totalruns = data["runs"] as? Int {
            run = totalruns
        }
        if let playerName = data["playerName"] as? String {
            name = playerName
        }
        if let maidenOvers = data["maidenOvers"] as? Int {
            maidenOver = maidenOvers
        }
        if let ecoRate = data["economyRate"] as? Double {
            economyRate = ecoRate
        }
        let bowler = Bowler(name: name, over: over, ball: ball, maiden: maidenOver, wicket: wicket, run: run, economyRate: economyRate)
        return bowler
        
    }
    
    func fetchLivePartnershipData(data: [String: Any]) -> PartnerShip {
        var run = 0
        var ball = 0
        
        if let runs = data["partnershipRuns"] as? Int {
            run = runs
        }
        if let balls = data["totalPartnershipBalls"] as? Int {
            ball = balls
        }
        let partnership = PartnerShip(run: run, ball: ball)
    
        return partnership
    }
    
    func fetchLiveFallOfWicketData(data: [String: Any]) -> FallOfWicket {
        var run = 0
        var wicket = 0
        var ball = 0
        var over = 0

        if let runs = data["score"] as? Int {
            run = runs
        }
        if let balls = data["balls"] as? Int {
            ball = balls
        }
        if let overs = data["overs"] as? Int {
            over = overs
        }
        if let wickets = data["wicketNumber"] as? Int {
            wicket = wickets
        }
        
        let fallOfWicket = FallOfWicket(run: run, wicket: wicket, ball: ball, over: over)
        return fallOfWicket
    }
    
    func fetchLiveCommentary(data: [String: Any]) -> Commentary  {
        
        var ballStatus = ""
        var ball = 0
        var over = 0
        var run = 0
        var comment = ""
        var isOverComplete = false
        
        if let status = data["ballStatus"] as? String {
            ballStatus = status
        }
        if let balls = data["balls"] as? Int {
            ball = balls
        }
        if let overs = data["overs"] as? Int {
            over = overs
        }
        if let runs = data["runs"] as? Int {
            run = runs
        }
        if let commentData = data["comment"] as? String {
            comment = commentData
        }
        if let overStatus = data["overStatus"] as? String {
            if overStatus == "COMPLETED" {
                isOverComplete = true
            }
        }
        
        let commentary = Commentary(ballStatus: ballStatus, ball: ball, over: over, run: run, overStatus: isOverComplete, comment: comment)
        return commentary
        
    }
    
    func getMatchInfo(completion: @escaping (Bool?, Error?) -> Void) {
        setParameterForGetMatchInfo()
        let url = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/match/view-info"
        let queryUrl = URL(string: url)
        if queryUrl != nil { network.getTournamentOverViewData(url: url, headers: parametersForGetMatchInfo){ (apiData, statusCode, error) in
            if let apiData = apiData {
                self.fetchMatchInfoDetails(data: apiData)
                completion(true, nil)
            }
        }
        }
    }
    
    private func setParameterForGetMatchInfo() {
        guard let tournamentId = currentTournamentId else {
            return
        }
        guard let matchId = currentMatchId else {
            return
        }
        parametersForGetMatchInfo["tournamentId"] = String(tournamentId)
        parametersForGetMatchInfo["matchId"] = String(matchId)
    }
    
    private func fetchMatchInfoDetails(data: [String: Any]) {
        var matchInfo = MatchInformation(tournamentId: Int64(0), matchId: Int64(0), matchNumber: 0, teamOne: "", teamTwo: "", teamOneId: Int64(0), teamTwoId: Int64(0), groundName: "", matchDate: "", matchDay: "", matchStartTime: "", umpireName: "")
        if let matches = data["matches"] as? [String: Any] {
            if let id = matches["matchId"] as? Int64 {
                matchInfo.matchId = id
            }
            if let id = matches["tournamentId"] as? Int64 {
                matchInfo.tournamentId = id
            }
            if let matchNumber = matches["matchNumber"] as? Int {
                matchInfo.matchNumber = matchNumber
            }
            if let name = matches["groundName"] as? String {
                matchInfo.groundName = name
            }
            if let name = matches["umpireName"] as? String {
                matchInfo.umpireName = name
            }
            if let date = matches["matchDate"] as? String {
                matchInfo.matchDate = date
            }
            if let day = matches["matchDay"] as? String {
                matchInfo.matchDay = day
            }
            if let time = matches["matchStartTime"] as? String {
                matchInfo.matchStartTime = time
            }
        }
        if let versus = data["versus"] as? [[String: Any]] {
            if let team = versus[0]["teamName"] as? String {
                matchInfo.teamOne = team
            }
            if let id = versus[0]["teamId"] as? Int64 {
                matchInfo.teamOneId = id
            }
            if let team = versus[1]["teamName"] as? String {
                matchInfo.teamTwo = team
            }
            if let id = versus[1]["teamId"] as? Int64 {
                matchInfo.teamTwoId = id
            }
        }
        
        self.currentMatchInfo = matchInfo
        setVersusData()
    }
    
    func fetchRequiredIdToGetScore(index: Int) -> [String: Any]? {
        var param: [String: Any] = [:]
        let tournamentId = currentTournamentId
        let matchId = versus[index].matchId
        let teamId = versus[index].teamId
        param["tournamentId"] = tournamentId
        param["matchId"] = matchId
        param["teamId"] = teamId
        return param
    }
    
    func setVersusData() {
        self.versus = []
        if let matchInfo = currentMatchInfo {
            let teamOne = Versus(matchId: matchInfo.matchId, teamId: matchInfo.teamOneId, teamName: matchInfo.teamOne, isCancelled: false)
            let teamTwo = Versus(matchId: matchInfo.matchId, teamId: matchInfo.teamTwoId, teamName: matchInfo.teamTwo, isCancelled: false)
            versus.append(teamOne)
            versus.append(teamTwo)
        }
    }
    
}
