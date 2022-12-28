//
//  HomeViewModel.swift
//  Cric Champs
//
//  Created by Dhanush Devadiga on 19/12/22.
//

import Foundation

class HomeViewModel {
    static var shared = HomeViewModel()
    var user: User?
    var network = NetworkManager()
    var header = ["touranmentCode": ""]
    var code: String?
    var currentTournamentId: Int64?
    
    func getUserDetail(completion: @escaping (Int64?, String?, Error?) -> Void) {
        setHeader()
        let url = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/tournament/show"
        let queryUrl = URL(string: url)
        if queryUrl != nil { network.getTournamentOverViewData(url: url, headers: header){ (apiData, statusCode, error) in
            if statusCode == 200 {
                if let data = apiData {
                    let id = data["userId"] as? Int64
                    let tournamnetId = data["tournamentId"] as? Int64
                    self.currentTournamentId = tournamnetId
                    completion(id, nil , nil)
                }
            } else if statusCode == 404 {
                if let data = apiData {
                    let message = data["Error Message "] as? String
                        completion(nil, message, nil)
                }
            }
            else {
                print(error?.localizedDescription as Any)
                }
            }
        }
    }
    
    private func setHeader() {
        guard let code = code else{
            return
        }
        header["tournamentCode"] = code
    }
}
