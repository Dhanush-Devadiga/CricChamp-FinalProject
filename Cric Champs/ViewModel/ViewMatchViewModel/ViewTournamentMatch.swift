//
//  ViewTournament.swift
//  Cric Champs
//
//  Created by Dhanush Devadiga on 26/12/22.
//

import Foundation

class ViewTournamentMatch {
    static var shared = ViewTournamentMatch()
    var network = NetworkManager()
    var homeViewModel = HomeViewModel.shared
    
    var grounds : [Ground] = []
    var getGroundHeader: [String : String] = [:]
    
    var umpires = [Umpire]()
    var getUmpireHeader: [String : String] = [:]
    
    var teams = [TeamInfo]()
    var getTeamHeader: [String : String] = [:]
    
    var  getPlayerHeader: [String : String] = [:]
    var players = [PlayersInfo]()
    
    var matches = [MatchInfo]()
    var segrageatedMatches : [[MatchInfo]] = []
    var uniqueDates: Set<String> = []
    
    func computeNumberOfSectionsRequired() -> Int {
        var uniqueDates: Set<String> = []
        matches.forEach { (match) in
            uniqueDates.insert(match.matchDate)
        }
        self.uniqueDates = uniqueDates
        return uniqueDates.count
    }
    
    func segregateListMatches(each uniqueDates: Set<String>) {
        var list: [[MatchInfo]] = []
        for date in uniqueDates {
            var tempMatches = [MatchInfo]()
            matches.forEach { (match) in
                if date == match.matchDate {
                    tempMatches.append(match)
                }
            }
            list.append(tempMatches)
        }
        segrageatedMatches = list
    }
    
    func computeNumberOfRowsInSection(section: Int) -> Int {
        segregateListMatches(each: uniqueDates)
        return segrageatedMatches[section].count
    }
    
    func getGrounds(completion: @escaping (Bool, Error?) -> Void) {
        setHeaderForGetGrounds()
        let url = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/name/grounds"
        let queryUrl = URL(string: url)
        var allGrounds = [Ground]()
        if queryUrl != nil { network.getTournamentData(url: url, headers: getGroundHeader) { (apidata, statusCode, error) in
            if let data = apidata {
                for ground in data {
                    let result = self.fetchGroundData(data: ground)
                    allGrounds.append(result)
                }
                self.grounds = allGrounds
                completion(true, nil)
            } else {
                print(error?.localizedDescription as Any)
                completion(false, error)
            }
        }
        }
    }
    
    func fetchGroundData(data: [String: Any]) -> Ground {
        var ground = Ground(id: Int64(0), tournamentId: nil, groundName: "", city: "", groundLocation: "", latitude: 0.0, longitude: 0.0, groundPhoto: "", isSaved: true)
            
            if let groundId = data["id"] as? Int64 {
                ground.id = groundId
            }
            if let name = data["name"] as? String {
                ground.groundName = name
            }
            if let city = data["city"] as? String {
                ground.city = city
            }
            if let photo = data["photo"] as? String {
                ground.groundPhoto = photo
            }
        return ground
    }
    
    private func setHeaderForGetGrounds() {
        getGroundHeader = [:]
        if homeViewModel.user == nil {
            getGroundHeader["tournamentId"] = String(homeViewModel.currentTournamentId!)
        } else {
            getGroundHeader["Authorization"] = homeViewModel.user?.authorization
            getGroundHeader["tournamentId"] = String(homeViewModel.currentTournamentId!)
        }
    }
    
    func getUmpire(completion: @escaping ([Umpire]?, Error?) -> Void) {
        self.setHeaderForGetUmpire()
        let url = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/name/umpires"
        let queryUrl = URL(string: url)
        var umpData = [Umpire]()
        if queryUrl != nil { network.getTournamentData(url: url, headers: getUmpireHeader) { (apidata, statusCode, error) in
            if statusCode == 200 {
                if let data = apidata {
                    for element in data {
                        let umpire = self.fetchUmpireData(data: element)
                        umpData.append(umpire)
                    }
                    self.umpires = umpData
                    completion(umpData, nil)
                }
            } else {
                completion(nil, error)
            }
        }
        }
    }
    
    func fetchUmpireData(data: [String: Any]) -> Umpire {
        var umpire = Umpire(id: Int64(0), tournamentId: nil, name: "", place: "", phone: nil, isSaved: true, profile: "")
        if let id = data["id"] as? Int64 {
            umpire.id = id
        }
        if let name = data["name"] as? String {
            umpire.name = name
        }
        if let profile = data["photo"] as? String {
            umpire.profile = profile
        }
        return umpire
    }
    
    private func setHeaderForGetUmpire() {
        getUmpireHeader = [:]
        if homeViewModel.user == nil {
            getUmpireHeader["tournamentId"] = String(homeViewModel.currentTournamentId!)
        } else {
            getUmpireHeader["Authorization"] = homeViewModel.user?.authorization
            getUmpireHeader["tournamentId"] = String(homeViewModel.currentTournamentId!)
        }
    }
    
    func getTeamInfo(completion: @escaping ([TeamInfo]?, Error?) -> Void) {
        setHeaderForGetTeams()
        let url = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/team/view-all"
        let queryUrl = URL(string: url)
        var teamData = [TeamInfo]()
        if queryUrl != nil { network.getTournamentData(url: url, headers: getTeamHeader) { (apidata, statusCode, error) in
            if let data = apidata {
                teamData =  self.fetchTeamData(data: data)
                completion(teamData, nil)
            } else {
                print(error?.localizedDescription as Any)
            }
        }
        }
    }
    
    func fetchTeamData(data: [[String: Any]]) -> [TeamInfo] {
            var allTeams = [TeamInfo]()
            var teamId = Int64(0)
            var tournamentId = Int64(0)
            var teamName = ""
            var captainName = ""
            var city = ""
            var numberOfPlayers = 0
            var totalMatchesPlayed = 0
            var totalWins = 0
            var totalLosses = 0
            var totalDrawOrCancelledOrNoResult = 0
            var points = 0
            var teamHighestScore = 0
            var netRunRate = 0.0
            var teamLogo = ""
            var teamStatus = ""
            var isDeleted = false
            
            for index in data {
                if let id = index["teamId"] as? Int64 {
                    teamId = id
                }
                
                if let id = index["tournamentId"] as? Int64 {
                    tournamentId = id
                }
                
                if let id = index["teamName"] as? String {
                    teamName = id
                }
                if let id = index["captainName"] as? String {
                    captainName = id
                }
                if let id = index["city"] as? String {
                    city = id
                }
                if let id = index["numberOfPlayers"] as? Int {
                    numberOfPlayers = id
                }
                if let id = index["totalMatchesPlayed"] as? Int {
                    totalMatchesPlayed = id
                }
                if let id = index["totalWins"] as? Int {
                    totalWins = id
                }
                if let id = index["totalLosses"] as? Int {
                    totalLosses = id
                }
                if let id = index["totalDrawOrCancelledOrNoResult"] as? Int {
                    totalDrawOrCancelledOrNoResult = id
                }
                if let id = index["points"] as? Int {
                    points = id
                }
                if let id = index["teamHighestScore"] as? Int {
                    teamHighestScore = id
                }
                if let id = index["netRunRate"] as? Double {
                    netRunRate = id
                }
                if let id = index["teamLogo"] as? String {
                    teamLogo = id
                }
                if let id = index["teamStatus"] as? String {
                    teamStatus = id
                }
                if let id = index["isDeleted"] as? Bool {
                    isDeleted = id
                }
                
                let  teamm = TeamInfo(teamId: Int64(teamId), tournamentId: tournamentId, teamName: teamName, captainName: captainName, city: city, numberOfPlayers: numberOfPlayers, totalMatchesPlayed: totalMatchesPlayed, totalWins: totalWins, totalLosses: totalLosses, totalDrawOrCancelledOrNoResult: totalDrawOrCancelledOrNoResult, points: points, teamHighestScore: teamHighestScore, netRunRate: netRunRate, teamLogo: teamLogo, teamStatus: teamStatus, isDeleted: isDeleted)
                allTeams.append(teamm)
            }
        self.teams = allTeams
        return teams
    }
    
    func getMatchhInfo(completion: @escaping ([MatchInfo]?, Error?) -> Void) {
        setHeaderForGetTeams()
        let url = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/match/info"
        let queryUrl = URL(string: url)
        var matchData = [MatchInfo]()
        if queryUrl != nil { network.getTournamentData(url: url, headers: getTeamHeader) { (apidata, statusCode, error) in
            if let data = apidata {
                matchData =  self.fetchMatchhData(data: data)
                completion(matchData, nil)
            } else {
                print(error?.localizedDescription as Any)
            }
        }
        }
    }
    
    func fetchMatchhData(data: [[String: Any]]) -> [MatchInfo] {
            var allMatchs = [MatchInfo]()
        
        var tournamentId = Int64(0)
        var matchId = Int64(0)
        var groundId = Int64(0)
        var groundName = ""
        var matchStatus = ""
        var matchDate = ""
        var matchDay = ""
        var matchStartTime = ""
        var matchEndTime = ""
        var firstTeamId = Int64(0)
        var firstTeamName = ""
        var firstTotalScore = 0
        var firstTotalWickets = 0
        var firstTotalOverPlayed = 0
        var firstTotalBallsPlayed = 0
        var firstTeamMatchResult = ""
        var secondTeamId = Int64(0)
        var secondTeamName = ""
        var secondTotalScore = 0
        var secondTotalWickets = 0
        var secondTotalOverPlayed = 0
        var secondTotalBallsPlayed = 0
        var secondTeamMatchResult = ""
        var cancelledReason = ""
            
            for index in data {
                if let id = index["tournamentId"] as? Int64 {
                    tournamentId = id
                }
                
                if let id = index["matchId"] as? Int64 {
                    matchId = id
                }
                
                if let id = index["groundId"] as? Int64 {
                    groundId = id
                }
                if let id = index["groundName"] as? String {
                    groundName = id
                }
                if let id = index["matchStatus"] as? String {
                    matchStatus = id
                }
                if let id = index["matchDate"] as? String {
                    matchDate = id
                }
                if let id = index["matchDay"] as? String {
                    matchDay = id
                }
                if let id = index["matchStartTime"] as? String {
                    matchStartTime = id
                }
                if let id = index["matchEndTime"] as? String {
                    matchEndTime = id
                }
                if let id = index["firstTeamId"] as? Int64 {
                    firstTeamId = id
                }
                if let id = index["firstTeamName"] as? String {
                    firstTeamName = id
                }
                if let id = index["firstTotalScore"] as? Int {
                    firstTotalScore = id
                }
                if let id = index["firstTotalWickets"] as? Int {
                    firstTotalWickets = id
                }
                if let id = index["firstTotalOverPlayed"] as? Int {
                    firstTotalOverPlayed = id
                }
                if let id = index["firstTotalBallsPlayed"] as? Int {
                    firstTotalBallsPlayed = id
                }
                if let id = index["firstTeamMatchResult"] as? String {
                    firstTeamMatchResult = id
                }
                if let id = index["secondTeamId"] as? Int64 {
                    secondTeamId = id
                }
                if let id = index["secondTeamName"] as? String {
                    secondTeamName = id
                }
                if let id = index["secondTotalScore"] as? Int {
                    secondTotalScore = id
                }
                if let id = index["secondTotalWickets"] as? Int {
                    secondTotalWickets = id
                }
                if let id = index["secondTotalOverPlayed"] as? Int {
                    secondTotalOverPlayed = id
                }
                if let id = index["secondTotalBallsPlayed"] as? Int {
                    secondTotalBallsPlayed = id
                }
                if let id = index["secondTeamMatchResult"] as? String {
                    secondTeamMatchResult = id
                }
                if let id = index["cancelledReason"] as? String {
                    cancelledReason = id
                }
                
                let mathh = MatchInfo(tournamentId: tournamentId, matchId: matchId, groundId: groundId, groundName: groundName, matchStatus: matchStatus, matchDate: matchDate, matchDay: matchDay, matchStartTime: matchStartTime, matchEndTime: matchEndTime, firstTeamId: firstTeamId, firstTeamName: firstTeamName, firstTotalScore: firstTotalScore, firstTotalWickets: firstTotalWickets, firstTotalOverPlayed: firstTotalOverPlayed, firstTotalBallsPlayed: firstTotalBallsPlayed, firstTeamMatchResult: firstTeamMatchResult, secondTeamId: secondTeamId, secondTeamName: secondTeamName, secondTotalScore: secondTotalScore, secondTotalWickets: secondTotalWickets, secondTotalOverPlayed: secondTotalOverPlayed, secondTotalBallsPlayed: secondTotalBallsPlayed, secondTeamMatchResult: secondTeamMatchResult, cancelledReason: cancelledReason)
              
                allMatchs.append(mathh)
            }
        self.matches = allMatchs
        return matches
    }
    
    private func setHeaderForGetTeams() {
        getTeamHeader = [:]
        if homeViewModel.user == nil {
            getTeamHeader["tournamentId"] = String(homeViewModel.currentTournamentId!)
        } else {
            getTeamHeader["Authorization"] = homeViewModel.user?.authorization
            getTeamHeader["tournamentId"] = String(homeViewModel.currentTournamentId!)
        }
    }
    
    func getPlayerInfo(completion: @escaping ([PlayersInfo]?, Error?) -> Void) {
        let url = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/player/view"
        let queryUrl = URL(string: url)
        var teamData = [PlayersInfo]()
        if queryUrl != nil { network.getTournamentData(url: url, headers: getTeamHeader) { (apidata, statusCode, error) in
            if let data = apidata {
                teamData =  self.fetchPlayerData(data: data)
                completion(teamData, nil)
            } else {
                print(error?.localizedDescription as Any)
            }
        }
        }
    }
    
    func fetchPlayerData(data: [[String: Any]]) -> [PlayersInfo] {

            var playerId = Int64(0)
            var tournamentId = Int64(0)
            var teamId = Int64(0)
            var playerName = ""
            var battingAverage = 0.0
            var battingStrikeRate = 0.0
            var totalFifties = 0
            var totalHundreds = 0
            var totalFours = 0
            var totalSixes = 0
            var mostWickets = 0
            var totalRuns = 0
            var bestBowlingAverage = 0.0
            var bestBowlingEconomy = 0.0
            var bestBowlingStrikeRate = 0.0
            var mostFiveWicketsHaul = 0
            
            for data in data {
                if let id = data["playerId"] as? Int64 {
                    playerId = id
                }
                if let id = data["tournamentId"] as? Int64 {
                    tournamentId = id
                }
                if let id = data["teamId"] as? Int64 {
                    teamId = id
                }
                
                if let id = data["playerName"] as? String {
                    playerName = id
                }
                
                if let id = data["battingAverage"] as? Double {
                    battingAverage = id
                }
                
                if let id = data["battingStrikeRate"] as? Double {
                    battingStrikeRate = id
                }
                if let id = data["totalFifties"] as? Int {
                    totalFifties = id
                }
                if let id = data["totalHundreds"] as? Int {
                    totalHundreds = id
                }
                if let id = data["totalFours"] as? Int {
                    totalFours = id
                }
                if let id = data["totalSixes"] as? Int {
                    totalSixes = id
                }
                if let id = data["mostWickets"] as? Int {
                    mostWickets = id
                }
                if let id = data["totalRuns"] as? Int {
                    totalRuns = id
                }
                if let id = data["bestBowlingAverage"] as? Double {
                    bestBowlingAverage = id
                }
                if let id = data["bestBowlingEconomy"] as? Double {
                    bestBowlingEconomy = id
                }
                if let id = data["bestBowlingStrikeRate"] as? Double {
                    bestBowlingStrikeRate = id
                }
                if let id = data["mostFiveWicketsHaul"] as? Int {
                    mostFiveWicketsHaul = id
                }
                
                let playeer = PlayersInfo(playerId:playerId, tournamentId:tournamentId, teamId:teamId, playerName: playerName, battingAverage: battingAverage, battingStrikeRate: battingStrikeRate, totalFifties: totalFifties, totalHundreds: totalHundreds, totalFours: totalFours, totalSixes: totalSixes, mostWickets: mostWickets, totalRuns: totalRuns, bestBowlingAverage: bestBowlingAverage, bestBowlingEconomy: bestBowlingEconomy, bestBowlingStrikeRate: bestBowlingStrikeRate, mostFiveWicketsHaul: mostFiveWicketsHaul)
                self.players.append(playeer)
            }
        return players
    }
    
    private func setHeaderForGetPlayerInfo() {
        if homeViewModel.user == nil {
            getGroundHeader["tournamentId"] = String(homeViewModel.currentTournamentId!)
        } else {
            getGroundHeader["Authorization"] = homeViewModel.user?.authorization
            getGroundHeader["tournamentId"] = String(homeViewModel.currentTournamentId!)
        }
    }
}
