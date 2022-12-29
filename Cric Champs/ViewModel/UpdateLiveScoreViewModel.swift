//
//  UpdateLiveScoreViewModel.swift
//  UpdateLiveScore
//
//  Created by Preetam G on 12/12/22.
//

import Foundation
import UIKit

let baseURL = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com" // remove this when merged with main project

class UpdateLiveScoreViewModel {
    
    var delegate: Handler?
    let token = HomeViewModel.shared.user?.authorization
    
    let updateURl = "\(baseURL)/live/score/update"
    let getTeamIDURL = "\(baseURL)/match/view-versus"
    let getPlayersURL = "\(baseURL)/player/view-all?pageNumber=1&pageSize=100"
    let scorecardURL = "\(baseURL)/scoreboard/"
    
    let getRemainingBatsmenURL = "\(baseURL)/live/score/remaining-batsman"
    let getFielderURl = "\(baseURL)/live/score/fielders"
    let getRemainingBowlerURL = "\(baseURL)/live/score/remaining-bowlers"
    let getCurrentBatsmenURL = "\(baseURL)/live/score/currentBatsman"
 
    var headers = [ "Authorization" : "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkaGFudUBnbWFpbC5jb20iLCJleHAiOjE2NzIyMTMzODMsImlhdCI6MTY3MjEyNjk4M30.MfyabEBB1DS5j06g1JfMMvMeeQKdbck-AztpDq862j4LwzZKqEtGFgU9xOfKx8nU6gpk3Tzr_WaOKNW6pzMGvw"]
 
    var getTeamsHeaders: [String: String] = [
        "Authorization" : "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkaGFudUBnbWFpbC5jb20iLCJleHAiOjE2NzIyMTMzODMsImlhdCI6MTY3MjEyNjk4M30.MfyabEBB1DS5j06g1JfMMvMeeQKdbck-AztpDq862j4LwzZKqEtGFgU9xOfKx8nU6gpk3Tzr_WaOKNW6pzMGvw",
        "tournamentId": "1",
        "matchId": "3"
    ]
     
    var getPlayersHeaders: [String: String] = [
        "Authorization" : "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkaGFudUBnbWFpbC5jb20iLCJleHAiOjE2NzIyMTMzODMsImlhdCI6MTY3MjEyNjk4M30.MfyabEBB1DS5j06g1JfMMvMeeQKdbck-AztpDq862j4LwzZKqEtGFgU9xOfKx8nU6gpk3Tzr_WaOKNW6pzMGvw",
        "tournamentId": "1",
        "teamId": "1"
    ]
    
    var liveGetPlayerHeader: [String: String] = [
        "Authorization" : "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkaGFudUBnbWFpbC5jb20iLCJleHAiOjE2NzIyMTMzODMsImlhdCI6MTY3MjEyNjk4M30.MfyabEBB1DS5j06g1JfMMvMeeQKdbck-AztpDq862j4LwzZKqEtGFgU9xOfKx8nU6gpk3Tzr_WaOKNW6pzMGvw",
        "tournamentId": "1",
        "teamId": "1",
        "matchId": "10"
    ]
    
    var scorecardHeaders: [String: String] = [
        "tournamentId": "1",
        "matchId": "4",
        "teamId": "2"
    ]
    
    var parameters: [String: Any?] = [
        "extraModel": [
            "extraStatus": false,
            "extraType": "wide"
        ],
        
        "wicketModel": [
            "wicketStatus": false,
            "outType": "STUMPED",
            "outPlayerId": 1,
            "fielderId": 6,
            "newBatsmanId": 11
        ],
        
        "tournamentId": 1,
        
        "matchId": 1,
        
        "battingTeamId": 1,
        
        "bowlingTeamId": 3,
        
        "strikeBatsmanId": 2,
        
        "nonStrikeBatsmanId": 1,
        
        "bowlerId": 6,
        
        "over": 0,
        
        "ball": 0,
        
        "runs": 2,
        
        "overStatus": nil,
        
        "matchStatus": "FIRSTINNING"
    ]
    
    var tournamentId: Int = 89
    var matchID: Int = 18
    var team1ID: Int = 43
    var team2ID: Int = 44
    var currentBattingTeamID: Int = 1
    var currentBowlingTeamID: Int = 3
    var currentlySelectedRun: Int = 0
    var strikerBatsmanId: Int = 2
    var nonStrikerBatsmanId: Int = 1
    var bowlerId: Int = 6
    var outplayerId: Int?
    var feilderId: Int?
    var newBatsmanId: Int?
    var currentExtraRun: Int?
    var currentExtra: ExtraType?
    var over: Int = 0
    var ball: Int = 0
    var run: Int = 0
    
    var currentlyWicketTypeSelected: WicketType?
    var currentOutPlayerID: Int? = 0
    var matchAbondendReason: String?
    var batsman: String = "Shailesh"
    var fielder: String?
    var bowler: String = "Shahikanth D"
    var wicketKeeper: String?
    var doesNeedBowlerSelection: Bool = false
    var bowlerSelection = false
    var batsmanSelection = false
    var nonStrikerSelection = false
    var reasonSelction = false
    var fielderSelection = false
    var firstLoad = true
    var nextBatsmanSelection = false
    var currentBatsmanSelection = false
    
    var statusLabelText = ""
    var wicketLabelText = ""
    var extraLabelText = ""
    var runLabelText = ""
    var descriptionLabelText = "Run out by Pratik D"
    var runsDescriptionLabelText = ""
    var oversLabelText = "0.0 Overs"
    var scoreLabelText = "0/0"
    var team1Name = "UDL Strikers"
    var team2Name = "Paras XI"
    
    var battingPlayers: [PlayerStruct] = []
    var currentBatsmen: [PlayerStruct] = []
    var remainingBatsmen: [PlayerStruct] = []
    var remainingFielder: [PlayerStruct] = []
    var remainingBowler: [PlayerStruct] = []
    var bowlingPlayers: [PlayerStruct] = []
    var listPlayers: [PlayerStruct] = []
    var reasons: [String] = ["UDL Strikers didnt show Up", "Paras XI didnt show up", "Bad Weather", "Other"]
    var currentReason: String = ""
    
    var currentMatchStatus: MatchStatus = MatchStatus.FIRSTINNING
    var currentOverStatus: OverStatus?
    var stopScoreboardUpdate = false
    
    func updateHeaders() {
        headers["Authorization"] = token
        getTeamsHeaders["Authorization"] = token
        getPlayersHeaders["Authorization"] = token
        liveGetPlayerHeader["Authorization"] = token
        scorecardHeaders["Authorization"] = token
    }
    
    func getScoreboard(completion: @escaping(() -> Void)) {
        configureScoreboardParams()
        print("scoreboard parameters: ", scorecardHeaders)
        print("scoreboard url: ", scorecardURL)
        let manager = NetworkManager()
        manager.getScoreBoardAPICall(url: scorecardURL, headers: scorecardHeaders) { (body, data, error, statusCode) in

            if statusCode == 200 {
                let score = data?["score"]
                let wickets = data?["totalWicketFall"]
                let ballSB = data?["ball"]
                let overs = data?["overs"]

                self.oversLabelText = "\(String(describing: overs ?? 0)).\(String(describing: ballSB ?? 0)) overs"
                self.scoreLabelText = "\(String(describing: score ?? 0))/\(String(describing: wickets ?? 0))"
                completion()
            } else {
                completion()
                DispatchQueue.main.async{self.delegate?.showAlert(title: "Scoreboard Update failed", message: "Couldn't update the scoreboard, \(body)")}
            }
        }
    }
    
    func callUpdateLiveScoreAPI(completion: @escaping(()->Void)) {
        configureParams()
        print("parametrs: ",parameters)
        let manager = NetworkManager()
        manager.postLiveScore(url: self.updateURl, parameters: self.parameters as [String : Any], headers: self.headers) { (body, response, error, statusCode) in
            guard let data = response else { print("nil data found"); return }
            
            if statusCode == 200 {
                self.assignParametersUsingResponse(data: data)
                
            } else {
                DispatchQueue.main.async {self.delegate?.showAlert(title: "Error", message: body)}
            }
            if self.stopScoreboardUpdate {
                completion()
            } else {
                self.getScoreboard {
                    completion()
                }
            }
        }
        
        
    }
    
    func getTeams(completion: @escaping((Int) -> Void)) {
        
        configureGetTeamsHeaders()
        let manager = NetworkManager()
        manager.getTournamentData(url: getTeamIDURL, headers: getTeamsHeaders) { (responseData, responseCode, error)  in
            guard let data = responseData else {print("nil data found"); return }
            
            guard let team1Dict = data.first else {
                print("team1DictError")
                return
            }
            
            let team2Dict = data[1]
            
            self.matchID = team1Dict["matchId"] as! Int
            self.team1ID = team1Dict["teamId"] as! Int
            self.team1Name = team1Dict["teamName"] as! String
            self.team2Name = team2Dict["teamName"] as! String
            self.team2ID = team2Dict["teamId"] as! Int
            //            self.getPlayers( { response in
            //                self.initialiseParams()
            //
            //            }
            
            self.currentBattingTeamID = self.team1ID
            self.currentBowlingTeamID = self.team2ID
            self.initialiseReasons()
            
            self.initialiseParams()
            completion(responseCode)
            self.refresh()
        }
    }
    
    func configureGetTeamsHeaders() {
        getTeamsHeaders["tournamentId"] = "\(tournamentId)"
        getTeamsHeaders["matchId"] = "\(matchID)"
    }
    
    func initialiseReasons() {
        reasons = ["\(team1Name) didn't show Up", "\(team2Name) didn't show up", "Bad weather", "Others"]
    }
    
    func getAllTeamPlayersForBothTeams(completion: @escaping((Int)->Void)) {
        var response = 404
        
        let group = DispatchGroup()
        let manager = NetworkManager()
        configureGetPlayerHeader(teamID: "\(currentBattingTeamID)")
        print(getPlayersHeaders, "GEt players headers")
        group.enter()
        manager.getTournamentData(url: getPlayersURL, headers: getPlayersHeaders) { (dict, response1, error) in
            if let list = dict {
                self.battingPlayers = self.createPlayerList(dict: list)
                self.strikerBatsmanId = self.battingPlayers.first?.playerId ?? 1
                self.nonStrikerBatsmanId = self.battingPlayers[1].playerId
            }
            if response1 != 200 {
                response = response1
            } else {
                response = 200
            }
            group.leave()
        }
        
        self.configureGetPlayerHeader(teamID: "\(self.currentBowlingTeamID)")
        
        group.enter()
        manager.getTournamentData(url: self.getPlayersURL, headers: self.getPlayersHeaders) { (dict2, response2, error) in
            if let list2 = dict2 {
                self.bowlingPlayers = self.createPlayerList(dict: list2)
                self.bowlerId = self.bowlingPlayers.first?.playerId ?? 1
            }
            
            response = response2
            if response2 == 200 {self.initialiseBattingTeamAndOpeners()}
            group.leave()
        }
        group.notify(queue: .main, execute: {completion(response)})
    }
    
    func getRemainingBatsmen(completion: @escaping(()->Void)) {
        liveScorePlayerHeaders(teamID: "\(currentBattingTeamID)")
        print(liveGetPlayerHeader, "headers")
        let manager = NetworkManager()
        manager.getTournamentData(url: getRemainingBatsmenURL, headers: liveGetPlayerHeader) { (dictionary, statusCode, error) in
            if statusCode == 200 {
                if let list = dictionary {
                    print(self.remainingBatsmen)
                    self.remainingBatsmen = self.createPlayerList(dict: list)
                    completion()
                }
            } else {
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Remaining Batsmen", message: "Couldn't fetch remaining batsmen list")
                }
            }
        }
    }
    
    func getCurrentBatsmen(completion: @escaping(()->Void)) {
        liveScorePlayerHeaders(teamID: "\(currentBattingTeamID)")
        let manager = NetworkManager()
        print(liveGetPlayerHeader, "send header")
        manager.getTournamentData(url: getCurrentBatsmenURL, headers: liveGetPlayerHeader) { (dictionary, statusCode, error) in
            if statusCode == 200 {
                if let list = dictionary {
                    self.currentBatsmen = self.createPlayerList(dict: list)
                    print(self.remainingBatsmen, "succcess")
                    completion()
                }
            } else {
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Current Batsmen", message: "Couldn't fetch current batsmen list")
                }
            }
            completion()
        }
    }
    
    func getFielder(completion: @escaping(()->Void)) {
        liveScorePlayerHeaders(teamID: "\(currentBowlingTeamID)")
        let manager = NetworkManager()
        manager.getTournamentData(url: getFielderURl, headers: liveGetPlayerHeader) { (dictionary, statusCode, error) in
            if statusCode == 200 {
                if let list = dictionary {
                    self.remainingFielder = self.createPlayerList(dict: list)
                    completion()
                }
            } else {
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Remaining Fielders", message: "Couldn't fetch fielders")
                }
            }
            completion()
        }
    }
    
    func getRemainingBowlers(completion: @escaping(()->Void)) {
        liveScorePlayerHeaders(teamID: "\(currentBowlingTeamID)")
        let manager = NetworkManager()
        manager.getTournamentData(url: getRemainingBowlerURL, headers: liveGetPlayerHeader) { (dictionary, statusCode, error) in
            if statusCode == 200 {
                if let list = dictionary {
                    self.remainingBowler = self.createPlayerList(dict: list)
                    completion()
                }
            } else {
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Remaining Bowler", message: "Couldn't fetch remaining bowlers list")
                }
            }
            completion()
        }
    }
    
    func initialiseBattingTeamAndOpeners() {
        currentBattingTeamID = team1ID
        currentBowlingTeamID = team2ID
        
        batsman = battingPlayers.first?.playerName ?? "Bob"
        bowler = bowlingPlayers.first?.playerName ?? "Jack"
    }
    
    func configureScoreboardParams() {
        scorecardHeaders["tournamentId"] = "\(self.tournamentId)"
        scorecardHeaders["matchId"] = "\(self.matchID)"
        scorecardHeaders["teamId"] = "\(self.currentBattingTeamID)"
    }
    
    func swapInnings() {
        let temp =  currentBattingTeamID
        currentBattingTeamID = currentBowlingTeamID
        currentBowlingTeamID = temp
        
        let tempPlayers = battingPlayers
        battingPlayers = bowlingPlayers
        bowlingPlayers = tempPlayers
        
        batsman = battingPlayers.first?.playerName ?? ""
        bowler = bowlingPlayers.first?.playerName ?? ""
        
        strikerBatsmanId = battingPlayers.first?.playerId ?? 1
        nonStrikerBatsmanId = battingPlayers[1].playerId
        bowlerId = bowlingPlayers.first?.playerId ?? 6
    }
    
    func createPlayerList(dict: [[String: Any]]) -> [PlayerStruct] {
        var list: [PlayerStruct] = []
        for player in dict {
            if let id = player["playerId"] as? Int {
                if let name = player["playerName"] as? String {
                    list.append(PlayerStruct(playerId: id, playerName: name))
                }
            }
        }
        return list
    }
    
    func configureGetPlayerHeader(teamID: String) {
        getPlayersHeaders["tournamentId"] = "\(tournamentId)"
        getPlayersHeaders["teamId"] = teamID
    }
    
    func liveScorePlayerHeaders(teamID: String) {
        liveGetPlayerHeader["tournamentId"] = "\(tournamentId)"
        liveGetPlayerHeader["matchId"] = "\(matchID)"
        liveGetPlayerHeader["teamId"] = teamID
    }
    
    func initialiseParams() {
        parameters["tournamentId"] = self.tournamentId
        parameters["matchId"] = self.matchID
        parameters["battingTeamId"] = self.team1ID
        parameters["bowlingTeamId"] = self.team2ID
        configureScoreboardParams()
        
    }
    
    func selectBowler() {
        changePlayerList(selection: SelectionType.BOWLER) {
            
        }
    }
    
    func selectBatsman() {
        changePlayerList(selection: SelectionType.STRIKER) {
            
        }
    }
    
    func configureParams() {
        
        var tempExtraDict = parameters["extraModel"] as! [String: Any]
        
        if let extra = currentExtra {
            tempExtraDict["extraStatus"] = true
            tempExtraDict["extraType"] = extra.rawValue
        } else {
            tempExtraDict["extraStatus"] = false
            tempExtraDict["extraType"] = ExtraType.wide.rawValue
        }
        
        parameters["extraModel"] = tempExtraDict
        
        var tempWicketDict = parameters["wicketModel"] as! [String: Any]
        
        if let wicket = currentlyWicketTypeSelected {
            tempWicketDict["wicketStatus"] = true
            tempWicketDict["outType"] = wicket.rawValue
            tempWicketDict["outPlayerId"] = strikerBatsmanId
            switch wicket {
            case .BOWLED: tempWicketDict["fielderId"] = bowlerId
            case .LBW: tempWicketDict["fielderId"] = bowlerId
            case .HITWICKET: tempWicketDict["fielderId"] = bowlerId
            case .STUMPED:
                tempWicketDict["fielderId"] = feilderId
            case .CAUGHT:
                tempWicketDict["fielderId"] = feilderId
            case .RUNOUT:
                tempWicketDict["fielderId"] = feilderId
            case .OTHERS:
                tempWicketDict["fielderId"] = feilderId
            }
            tempWicketDict["newBatsmanId"] = newBatsmanId
        } else {
            tempWicketDict["wicketStatus"] = false
            tempWicketDict["outType"] = WicketType.HITWICKET.rawValue
            tempWicketDict["outPlayerId"] = strikerBatsmanId
            tempWicketDict["fielderId"] = feilderId
            tempWicketDict["newBatsmanId"] = newBatsmanId
        }
        
        parameters["wicketModel"] = tempWicketDict
        
        parameters["tournamentId"] =  tournamentId
        
        parameters["battingTeamId"] =  currentBattingTeamID
        
        parameters["bowlingTeamId"] =  currentBowlingTeamID
        
        parameters["strikeBatsmanId"] =  strikerBatsmanId
        
        parameters["nonStrikeBatsmanId"] =  nonStrikerBatsmanId
        
        parameters["bowlerId"] =  bowlerId
        
        parameters["over"] = over
        
        parameters["ball"] =  ball
        
        parameters["runs"] = run + (currentExtraRun ?? 0)
        
        parameters["matchStatus"] = currentMatchStatus.rawValue
        
    }
    
    func assignParametersUsingResponse(data: [String: Any]) {
//        if let extra = data["extraModel"] as? [String: Any] {
//            if let extraStatus = extra["extraStatus"] as? Bool {
//                if extraStatus {
//                    if (extra["extraType"] as? String) != nil {
//
//                        currentExtra = nil
//                        currentExtraRun = 0
//                    }
//                } else {
//                    currentExtra = nil
//                    currentExtraRun = 0
//                }
//            }
//        }
        currentExtra = nil
        currentExtraRun = 0
        
        if let wicket = data["wicketModel"] as? [String: Any] {
            if let wicketStatus = wicket["wicketStatus"] as? Bool {
                if wicketStatus {
                    if let wicketType = wicket["wicketType"] as? String {
                        switch wicketType {
                        case "HITWICKET":
                            currentlyWicketTypeSelected = WicketType.HITWICKET
                        case "STUMPED":
                            currentlyWicketTypeSelected = WicketType.STUMPED
                        case "CAUGHT":
                            currentlyWicketTypeSelected = WicketType.CAUGHT
                        case "RUNOUT":
                            currentlyWicketTypeSelected = WicketType.RUNOUT
                        case "LBW":
                            currentlyWicketTypeSelected = WicketType.LBW
                        case "BOWLED":
                            currentlyWicketTypeSelected = WicketType.BOWLED
                        case "OTHERS":
                            currentlyWicketTypeSelected = WicketType.OTHERS
                        default:
                            currentlyWicketTypeSelected = WicketType.OTHERS
                        }
                    }
                } else {
                    currentlyWicketTypeSelected = nil
                }
            }
        }
        
        tournamentId =  data["tournamentId"] as! Int
        
        team1ID =  data["battingTeamId"] as! Int
        team1ID =  data["battingTeamId"] as! Int
        team1ID =  data["battingTeamId"] as! Int
        
        over = data["over"] as! Int
        
        ball =  data["ball"] as! Int
        
        strikerBatsmanId = data["strikeBatsmanId"] as! Int
        
        nonStrikerBatsmanId = data["nonStrikeBatsmanId"] as! Int
        
        bowlerId = data["bowlerId"] as! Int
        
        for player in battingPlayers {
            if player.playerId == strikerBatsmanId {
                batsman = player.playerName
            }
        }
        
        for player in bowlingPlayers {
            if player.playerId == bowlerId {
                bowler = player.playerName
            }
        }
        
        if ball == 0 {
            self.doesNeedBowlerSelection = true
        } else {
            self.doesNeedBowlerSelection = false
        }
        
        run = data["runs"] as! Int
        
        if let matchStatus = data["matchStatus"] as? String {
            stopScoreboardUpdate = false
            switch matchStatus {
            case "ABANDONED":
                currentMatchStatus = MatchStatus.ABANDONED
            case "PAST":
                currentMatchStatus = MatchStatus.PAST
            case "LIVE":
                currentMatchStatus = MatchStatus.LIVE
            case "UPCOMING":
                currentMatchStatus = MatchStatus.UPCOMING
            case "BYE":
                currentMatchStatus = MatchStatus.BYE
            case "INNINGCOMPLETED":
                handleInningsComplete()
            case "CANCELLED":
                currentMatchStatus = MatchStatus.CANCELLED
            case "FIRSTINNING":
                currentMatchStatus = MatchStatus.FIRSTINNING
            case "SECONDINNING":
                currentMatchStatus = MatchStatus.SECONDINNING
            case "INPROGRESS":
                currentMatchStatus = MatchStatus.INPROGRESS
            case "COMPLETED":
                stopScoreboardUpdate = true
                currentMatchStatus = MatchStatus.COMPLETED
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Match Completed", message: "Match is now completed, Thank You")
                }
            default:
                currentMatchStatus = MatchStatus.ABANDONED
            }
        }
        
        if (data["overStatus"] as? String) != nil {
            currentOverStatus = OverStatus.COMPLETED
            DispatchQueue.main.async{self.delegate?.overDidEndHandler()}
        } else {
            currentOverStatus = nil
        }
        configureParams()
    }
    
    func handleInningsComplete() {
        stopScoreboardUpdate = true
        swapInnings()
        over = 0
        run = 0
        ball = 0
        currentMatchStatus = MatchStatus.SECONDINNING
        DispatchQueue.main.async { self.delegate?.showAlert(title: "Innings Completed", message: "Teams Swapped") }
        configureParams()
    }
    
    func refresh() {
        
        self.doesNeedBowlerSelection = false
        currentExtra = nil
        currentlyWicketTypeSelected = nil
        noneSelection()
        
        currentExtraRun = nil
        matchAbondendReason = nil
        run = 0
        runLabelText = ""
        extraLabelText = ""
        oversLabelText = ""
        scoreLabelText = ""
        statusLabelText = ""
        wicketLabelText = ""
        descriptionLabelText = ""
        runsDescriptionLabelText = ""
    }
    
    func makeExtraDeselect() {
        currentExtra = nil
    }
    
    func updateScore(run: Int) {
        self.run = run
        configureParams()
    }
    
    
    
    func updateExtra(extra: ExtraType) {
        currentExtra = extra
        
        switch extra {
        case .wide:
            self.currentExtraRun = 1
        case .noBall:
            self.currentExtraRun = 1
        default :
            currentExtraRun = 0
            break
        }
        configureParams()
    }
    
    func updateWicket(wicket: WicketType, outplayerId: Int, bowler: Int, feilder: Int?, newBatsmanId: Int = 0) {
        currentlyWicketTypeSelected = wicket
        self.outplayerId = outplayerId
        self.bowlerId = bowler
        self.newBatsmanId = newBatsmanId
        if let feilder = feilder {
            self.feilderId = feilder
        }
        configureParams()
    }
    
    func shouldAllowUpdate() -> Bool {
        if currentlyWicketTypeSelected != nil {
            if outplayerId == nil && newBatsmanId == nil {
                return false
            } else {
                if currentlyWicketTypeSelected == WicketType.STUMPED || currentlyWicketTypeSelected == WicketType.RUNOUT || currentlyWicketTypeSelected == WicketType.CAUGHT {
                    if feilderId == nil {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    func changePlayerList(selection: SelectionType, _ completion: @escaping(() -> Void)) {
        switch selection {
        case .STRIKER:
            batsmanSelect()
            self.getRemainingBatsmen {
                self.listPlayers = self.remainingBatsmen
                completion()
            }
        case .NONSTRIKER:
            nonStrikerSelect()
            self.getRemainingBatsmen {
                self.listPlayers = self.remainingBatsmen
                completion()
            }
        case .REAMAININGBATSMEN:
            batsmanSelect()
            self.getRemainingBatsmen {
                self.listPlayers = self.remainingBatsmen
                completion()
            }
        case .BOWLER:
            bowlerSelecttion()
            self.getRemainingBowlers {
                self.listPlayers = self.remainingBowler
                completion()
            }
        case .REASON:
            reasonsSelection()
        case .FEILDER:
            fielderSelect()
            self.getFielder {
                self.listPlayers = self.remainingFielder
                completion()
            }
        case .NEXTBATSMAN:
            nextBatsmanSelect()
            self.getRemainingBatsmen {
                self.listPlayers = self.remainingBatsmen
                completion()
            }
        case .CURRENTWICKET:
            currentBatsmanSelect()
            self.getCurrentBatsmen {
                self.listPlayers = self.currentBatsmen
                completion()
            }
        }
    }
    
    private func currentBatsmanSelect() {
        currentBatsmanSelection = true
        batsmanSelection = false
        bowlerSelection = false
        reasonSelction = false
        fielderSelection = false
        nonStrikerSelection = false
        nextBatsmanSelection = false
    }
    
    private func nextBatsmanSelect() {
        currentBatsmanSelection = false
        batsmanSelection = false
        bowlerSelection = false
        reasonSelction = false
        fielderSelection = false
        nonStrikerSelection = false
        nextBatsmanSelection = true
    }
    
    private func batsmanSelect() {
        currentBatsmanSelection = false
        batsmanSelection = true
        bowlerSelection = false
        reasonSelction = false
        fielderSelection = false
        nonStrikerSelection = false
        nextBatsmanSelection = false
    }
    
    private func bowlerSelecttion() {
        currentBatsmanSelection = false
        batsmanSelection = false
        bowlerSelection = true
        reasonSelction = false
        fielderSelection = false
        nonStrikerSelection = false
        nextBatsmanSelection = false
    }
    
    private func fielderSelect() {
        currentBatsmanSelection = false
        batsmanSelection = false
        bowlerSelection = false
        reasonSelction = false
        fielderSelection = true
        nonStrikerSelection = false
        nextBatsmanSelection = false
    }
    
    private func reasonsSelection() {
        currentBatsmanSelection = false
        batsmanSelection = false
        bowlerSelection = false
        reasonSelction = true
        fielderSelection = false
        nonStrikerSelection = false
        nextBatsmanSelection = false
    }
    
    private func nonStrikerSelect() {
        currentBatsmanSelection = false
        batsmanSelection = false
        bowlerSelection = false
        reasonSelction = false
        fielderSelection = false
        nonStrikerSelection = true
        nextBatsmanSelection = false
    }
    
    private func noneSelection() {
        currentBatsmanSelection = false
        batsmanSelection = false
        bowlerSelection = false
        reasonSelction = false
        fielderSelection = false
        nonStrikerSelection = false
        nextBatsmanSelection = false
    }
    
    func updateWicketLabelText(with string: String) {
        wicketLabelText = string
    }
    
    func updateExtraLabelText(with string: String) {
        extraLabelText = string
    }
    
    func updateRunLabelText(with string: String) {
        runLabelText = "\(string) Runs"
    }
    
    func updateDescriptionLabelText(with string: String) {
        descriptionLabelText = string
    }
    
    func updaterunsScoredLabelText(with string: String) {
        runsDescriptionLabelText = string
    }
    
    func updateTourID(tournament id: Int) {
        self.tournamentId = id
    }
    
    func updateMatchID(match id: Int) {
        self.matchID = id
    }
    
    func updateCurrentOutPlayer(player id: Int) {
        self.outplayerId = id
    }
    
    func updateNextBatsmen(player id: Int) {
        self.newBatsmanId = id
    }
    
    func updateFielder(player id: Int) {
        self.feilderId = id
    }
    
    func viewModelInitialConfiguration(tournamentID: Int, matchId: Int) {
        self.tournamentId = tournamentID
        self.matchID = matchId
    }
}

enum SelectionType {
    case STRIKER, NONSTRIKER, REAMAININGBATSMEN, BOWLER, FEILDER, REASON, NEXTBATSMAN, CURRENTWICKET
}

enum OverStatus: String {
    case DONE, COMPLETED, NOTCOMPLETED, NULL
}
