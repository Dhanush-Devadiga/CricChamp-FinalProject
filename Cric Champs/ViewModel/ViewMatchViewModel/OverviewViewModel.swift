//
//  MatchViewModel.swift
//  demoooo
//
//  Created by Preetam G on 18/12/22.
//

import Foundation
import UIKit

protocol OverviewViewModelProtocol {
    func showFilterResponse(model: FilterResponseModel?)
}

class OverviewViewModel {
    
    var network = NetworkManager()
    var homeViewModel = HomeViewModel.shared
    var headerForGetMatch: [String: String] = [:]
    
    
    func makeDataRequest(completion: @escaping (MatchData?, Error?) -> Void) {
        setHeaderForGetMatch()
        let url = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/match/view-all"
        let queryUrl = URL(string: url)
        if queryUrl != nil { network.getTournamentData(url: url, headers: headerForGetMatch) { (apidata, statusCode, error) in
            if let data = apidata {
                let liveScore = self.fetchRequiredMatchData(data: data)
                completion(liveScore, nil)
            } else {
                print(error?.localizedDescription as Any)
            }
        }
        }
    }
    
    func fetchRequiredMatchData(data: [[String: Any]]) -> MatchData {
        versus = []
        matches = []
        for ele in data
        {
            if let matchesData = ele["matches"] as? [String:Any]{
                matches.append(fetchMatchData(data: matchesData ))
                
            }
            if let versusData = ele["versus"] as? [[String:Any]] {
                
                for index in 0..<versusData.count {
                        
                        versus.append(fetchVersusData(data: versusData[index]))
                }
            }
        }
        
        let matchess = MatchData(matches: matches, versus: versus)
        return matchess
        
    }
    
    private func setHeaderForGetMatch(){
        if homeViewModel.user == nil {
            headerForGetMatch["tournamentId"] = String(homeViewModel.currentTournamentId!)
        } else {
            headerForGetMatch["Authorization"] = homeViewModel.user?.authorization
            headerForGetMatch["tournamentId"] = String(homeViewModel.currentTournamentId!)
        }
    }
    
    func fetchMatchData(data: [String: Any]) -> viewMatch {
        var matchId = Int64(0)
        var tournamentId = Int64()
        var groundId = Int64(0)
        var groundName = ""
        var umpireId = Int64(0)
        var umpireName = ""
        var roundNumber = 0
        var matchNumber = 0
        var matchStatus = ""
        var matchDate = ""
        var matchDay = ""
        var matchStartTime = ""
        var matchEndTime = ""
        var totalNumberOfWicket = 0
        var isCancelled = ""
        var cancelledReason = ""
        
        if let id = data["matchId"] as? Int64 {
            matchId = id
        }
        
        if let id = data["tournamentId"] as? Int64 {
            tournamentId = id
        }
        
        if let id = data["groundId"] as? Int64 {
            groundId = id
        }
        if let id = data["groundName"] as? String {
            groundName = id
        }
        if let id = data["umpireId"] as? Int64 {
            umpireId = id
        }
        if let id = data["umpireName"] as? String {
            umpireName = id
        }
        if let id = data["roundNumber"] as? Int {
            roundNumber = id
        }
        if let id = data["matchNumber"] as? Int {
            matchNumber = id
        }
        if let id = data["matchStatus"] as? String {
            matchStatus = id
        }
        if let id = data["matchDate"] as? String {
            matchDate = id
        }
        if let id = data["matchDay"] as? String {
            matchDay = id
        }
        if let id = data["matchStartTime"] as? String {
            matchStartTime = id
        }
        if let id = data["matchEndTime"] as? String {
            matchEndTime = id
        }
        if let id = data["totalNumberOfWicket"] as? Int {
            totalNumberOfWicket = id
        }
        if let id = data["isCancelled"] as? String {
            isCancelled = id
        }
        if let id = data["cancelledReason"] as? String {
            cancelledReason = id
        }
        
        let matchh = viewMatch(matchId: matchId, tournamentId: tournamentId, groundId: groundId, groundName: groundName, umpireId: umpireId, umpireName: umpireName, roundNumber: roundNumber, matchNumber: matchNumber, matchStatus: matchStatus, matchDate: matchDate, matchDay: matchDay, matchStartTime: matchStartTime, matchEndTime: matchEndTime, totalNumberOfWicket: totalNumberOfWicket, isCancelled: isCancelled, cancelledReason: cancelledReason)
        
        return matchh
    }
    
    
    func fetchVersusData(data: [String: Any]) -> VTeams {
        
        var matchId = Int64(0)
        var teamId = Int64(0)
        var teamName = ""
        var totalScore = 0
        var totalWickets = 0
        var totalOverPlayed = 0
        var totalBallsPlayed = 0
        var matchResult = ""
        var isCancelled = ""
        
        if let id = data["matchId"] as? Int64 {
            matchId = id
        }
        if let id = data["teamId"] as? Int64 {
            teamId = id
        }
        if let id = data["teamName"] as? String {
            teamName = id
        }
        if let id = data["totalScore"] as? Int {
            totalScore = id
        }
        if let id = data["totalWickets"] as? Int {
            totalWickets = id
        }
        if let id = data["totalOverPlayed"] as? Int {
            totalOverPlayed = id
        }
        if let id = data["totalBallsPlayed"] as? Int {
            totalBallsPlayed = id
        }
        if let id = data["matchResult"] as? String {
            matchResult = id
        }
        if let id = data["isCancelled"] as? String {
            isCancelled = id
        }
        
        let team = VTeams(matchId : matchId, teamId : teamId, teamName : teamName, totalScore : totalScore, totalWickets : totalWickets, totalOverPlayed : totalOverPlayed, totalBallsPlayed : totalBallsPlayed, matchResult : matchResult, isCancelled : isCancelled)
        
        return team
    }
    
    var versus = [VTeams]()
    var matches: [viewMatch] = []
    var uniqueDates: Set<String> = []
    var segrageatedMatches : [[viewMatch]] = []
    
    var overviewViewModelProtocolDelegate: OverviewViewModelProtocol?

    var battingStats: [String] = []
    var bowlingStats: [String] = []
    var standings: [Standing] = []
    var grounds: [Ground] = []

    
    var view: OverviewViewModelProtocol?
    
    init (view: OverviewViewModelProtocol) {
        self.view = view
    }
    
    func computeNumberOfSectionsRequired() -> Int {
        var uniqueDates: Set<String> = []
        matches.forEach { (match) in
            uniqueDates.insert(match.matchDate)
        }
        self.uniqueDates = uniqueDates
        return uniqueDates.count
    }
    
    func segregateListMatches(each uniqueDates: Set<String>) {
        var list: [[viewMatch]] = []
        for date in uniqueDates {
            var tempMatches = [viewMatch]()
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
    
    func showFilterData() {
        let responseJsonModel = CricketFilterNewsResultModel.fromJSON(jsonFile: "filterFile") as CricketFilterNewsResultModel?
        overviewViewModelProtocolDelegate?.showFilterResponse(model: responseJsonModel?.response)
    }
    
    func createTempTeamsUmpires() {
        battingStats.append("Most Runs")
        battingStats.append("Best Batting average")
        battingStats.append("Best Batting Strike Rate")
        battingStats.append("Most Hundreds")
        battingStats.append("Most Fifties")
        battingStats.append("Most Fours")
        battingStats.append("Most Sixes")
        battingStats.append("Highest Score")
        bowlingStats.append("Most Wickets")
        bowlingStats.append("Best Bowling average")
        bowlingStats.append("Most 5 Wickets Hauls")
        bowlingStats.append("Best Economy")
        bowlingStats.append("Best Bowling Strike Rate")
        bowlingStats.append("Best Bowling")
        
    }
}

extension Decodable {
    static func fromJSON<T: Decodable>(jsonFile: String, fileExtension: String = "json", bundle: Bundle = .main) -> T? {
        guard let url = Bundle.main.url(forResource: jsonFile, withExtension: fileExtension),
              let data = try? Data(contentsOf: url),
              let output = try? JSONDecoder().decode(T.self, from: data)
        else {
            return nil
        }
        return output
    }
}

