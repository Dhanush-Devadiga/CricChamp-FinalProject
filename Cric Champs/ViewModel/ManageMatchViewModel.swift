//
//  MatchViewModel.swift
//  Cricket
//
//  Created by Preetam G on 06/12/22.
//

import Foundation
import UIKit

class ManageMatchViewModel {
    static var shared = ManageMatchViewModel()
    var network = NetworkManager()
    var homeViewModel = HomeViewModel.shared
    
    var matches = [MatchInfo]()
    var segrageatedMatches : [[MatchInfo]] = []
    var uniqueDates: Set<String> = []
    
    var headerForGetMatch: [String : String] = [:]
    var tournamentOverviewHeader: [String: String] = [:]
    
    let overViewURL = "\(baseURL)/tournament/view"
    var tournamentOverview: TournamentOverView?
    
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
    
    func makeDataRequest(completion: @escaping ([MatchInfo]?, Error?) -> Void) {
        setHeaderForGetMatches()
        let url = "\(baseURL)/match/info"
        let queryUrl = URL(string: url)
        var matchData = [MatchInfo]()
        if queryUrl != nil { network.getTournamentData(url: url, headers: headerForGetMatch) { (apidata, statusCode, error) in
            if let data = apidata {
                matchData =  self.fetchMatchhData(data: data)
                completion(matchData, nil)
            } else {
                print(error?.localizedDescription as Any)
            }
        }
        }
    }
    
    func setTournamentOverviewHeader() {
        tournamentOverviewHeader["Authorization"] = homeViewModel.user?.authorization
        tournamentOverviewHeader["tournamentId"] = String(homeViewModel.currentTournamentId!)
    }
    
    private func setHeaderForGetMatches() {
        headerForGetMatch = [:]
        if homeViewModel.user == nil {
            headerForGetMatch["tournamentId"] = String(homeViewModel.currentTournamentId!)
        } else {
            headerForGetMatch["Authorization"] = homeViewModel.user?.authorization
            headerForGetMatch["tournamentId"] = String(homeViewModel.currentTournamentId!)
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
    
    func fetchTournamentOverview(completion: @escaping((Bool, Error?) -> Void)) {
        let networkManager = NetworkManager()
        setTournamentOverviewHeader()
        networkManager.getTournamentOverViewData(url: overViewURL, headers: tournamentOverviewHeader) {data, response, error in
            if response == 200 {
                if let data = data {
                    let overView = self.fetchTournamentOverViewDetails(data: data)
                    self.tournamentOverview = overView
                    completion(true, nil)
                }
            } else {
                completion(false, error)
            }
        }
    }
    
    private func fetchTournamentOverViewDetails(data: [String: Any]) -> TournamentOverView {
        var tournamentOverView = TournamentOverView()
        
        if let id = data["tournamentId"] as? Int64 {
            tournamentOverView.tournamentId = id
        }
        if let name = data["tournamentName"] as? String {
            tournamentOverView.tournamentName = name
        }
        if let code = data["tournamentCode"] as? String {
            tournamentOverView.tournamentCode = code
        }
        if let date = data["tournamentStartDate"] as? String {
            tournamentOverView.tournamentStartDate = getDate(date: date)
        }
        if let date = data["tournamentEndDate"] as? String {
            tournamentOverView.tournamentEndDate = getDate(date: date)
        }
        if let time = data["tournamentStartTime"] as? String {
            tournamentOverView.tournamentStartTime = getTime(time: time)
        }
        if let time = data["tournamentEndTime"] as? String {
            tournamentOverView.tournamentEndTime = getTime(time: time)
        }
        if let teams = data["numberOfTeams"] as? Int {
            tournamentOverView.numberOfTeams = teams
        }
        if let overs = data["numberOfOvers"] as? Int {
            tournamentOverView.numberOfOvers = overs
        }
        if let grounds = data["numberOfGrounds"] as? Int {
            tournamentOverView.numberOfGrounds = grounds
        }
        if let umpires = data["numberOfUmpires"] as? Int {
            tournamentOverView.numberOfUmpires = umpires
        }
        if let status = data["tournamentStatus"] as? String {
            tournamentOverView.tournamentStatus = status
        }
        return tournamentOverView
    }
    
    private func getDate(date: String) -> String {
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let data = format.date(from: date)
        format.timeStyle = .short
        format.dateStyle = .medium
        format.dateFormat = "MMM dd yyyy"
        let dateValue = format.string(from: data!)
        let weekday = Calendar.current.component(.weekday, from: data!)
        let day = getWeekDay(weekDay: weekday)
        return day + ", " + dateValue
    }
    
    private func getTime(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: time)
        dateFormatter.dateFormat = "h:mm a"
        let convertedTime = dateFormatter.string(from: date!)
        return convertedTime
    }
    
    private func getWeekDay(weekDay: Int) -> String {
        switch  weekDay{
        case 1: return "Sun"
        case 2: return "Mon"
        case 3: return "Tue"
        case 4: return "Wed"
        case 5: return "Thu"
        case 6: return "Fri"
        case 7: return "Sat"
        default:
            return ""
        }
    }
    
}
