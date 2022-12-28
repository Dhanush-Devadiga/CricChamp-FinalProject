//
//  TimeViewModel.swift
//  calender
//
//  Created by Preetam G on 22/12/22.
//
//let baseURL = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com"
import Foundation

class TimeViewModel {
    var tournamentViewModel = TournamentViewModel.shared
    var currentSelect: Select?
    
    var startDate: Date?
    var endDate: Date?
    
    let setDateURL = "\(baseURL)/tournament/set-date"
    
    var setDateHeaders = [ "Authorization" : "",
                           "tournamentId": "",
                           "startDate": "2022-12-13",
                           "endDate": "2022-12-27"]
    var startTime: Date?
    var endTime: Date?
    
    let setTimeURL = "\(baseURL)/tournament/set-time"
    var delegate: TimeHandler?
    var startSelected = false
    
    var readyForPatch = false
    
    var setTimeHeaders = [ "Authorization" : "",
                           "tournamentId": "",
                           "startTime": "09:00:00",
                           "endTime": "10:00:00"]
    
    func assignTournamentId() {
        startSelected = true
        let data = tournamentViewModel.sendID()
        setTimeHeaders["tournamentId"] = String(data)
        setDateHeaders["tournamentId"] = String(data)
    }
    
    func assignStartTimeHeaders(start time: String) {
        setTimeHeaders["Authorization"] = tournamentViewModel.getToken()
        setTimeHeaders["startTime"] = time
        startSelected = true
    }
    
    func assignEndTimeHeaders(end time: String) {
        setTimeHeaders["Authorization"] = tournamentViewModel.getToken()
        setTimeHeaders["endTime"] = time
        self.readyForPatch = true
    }
    
    func assignStartDateHeaders(start date: String) {
        setDateHeaders["Authorization"] = tournamentViewModel.getToken()
        setDateHeaders["startDate"] = date
        startSelected = true
    }
    
    func assignEndDateHeaders(end date: String) {
        setDateHeaders["Authorization"] = tournamentViewModel.getToken()
        setDateHeaders["endDate"] = date
        self.readyForPatch = true
    }
    
    func patchDateTime(completion: @escaping((Int) -> Void)) {
        let manager = NetworkManager()
        assignTournamentId()
        var headers = [String: String] ()
        var url = ""
        if currentSelect == Select.DATE {
            headers = setDateHeaders
            url = setDateURL
        } else {
            url = setTimeURL
            headers = setTimeHeaders
        }
        manager.patchDateTime(url: url, parameters: [:], headers: headers, image: nil) { (message, statusCode, error) in
            if statusCode != 200 {
                DispatchQueue.main.async{self.delegate?.sendAlert(title: "Error message", message: message!)}
            } else {
                self.refresh()
                print("Time Update Success", error as Any)
            }
            completion(statusCode ?? 100)
        }
    }
    
    func refresh() {
        startSelected = false
        readyForPatch = false
    }

}

enum DateSelection {
    case STARTDATE, ENDDATE
}

enum Select {
    case DATE, TIME
}
