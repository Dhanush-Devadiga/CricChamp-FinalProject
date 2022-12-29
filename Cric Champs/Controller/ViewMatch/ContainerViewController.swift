//
//  NullViewController.swift
//  demoooo
//
//  Created by Prajwal Rao Kadam on 08/12/22.
//

import UIKit

class ContainerViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var index = 0
    var matchdatas : [MatchInfo]?
    var vm: OverviewViewModel?
    var teamInfo : [TeamInfo]?
    var viewTournament = ViewTournamentMatch()
    var liveScoreViewModel = LiveScoreViweMdoel.shared
    var umpiresinfo : [Umpire]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.vm = OverviewViewModel(view: self)
        registerCell()
        registerHeader()
        tableView.delegate = self
        tableView.dataSource = self
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let vc = self.parent as! ViewMatchContentController
        vc.swipeDelegate?.sendIndex(value: index)
        loadDataToTable()
    }
    
    private func loadDataToTable() {
        switch index {
        case 0: viewTournament.getMatchhInfo { (Matchinfo, error) in
            DispatchQueue.main.async
            {
                if Matchinfo != nil {
                    self.matchdatas = Matchinfo
                    self.tableView.reloadData()
                }
            }
        }

        case 1: viewTournament.getTeamInfo { (Teaminfo, error) in
            DispatchQueue.main.async
            {
                if Teaminfo != nil {
                    self.teamInfo = Teaminfo
                    self.tableView.reloadData()
                }
            }
        }
        case 2: viewTournament.getTeamInfo { (Teaminfo, error) in
            DispatchQueue.main.async
            {
                if Teaminfo != nil {
                    self.teamInfo = Teaminfo
                    self.tableView.reloadData()
                }
            }
        }
        case 3: return
        case 4:viewTournament.getGrounds { isSuccess, error in
            DispatchQueue.main.async
            {
                if isSuccess {
                    self.tableView.reloadData()
                } else {
                    print(error?.localizedDescription as Any)
                }
            }
        }
        case 5:viewTournament.getUmpire { (Umpireinfo, error) in
            DispatchQueue.main.async
            {
                if Umpireinfo != nil {
                    self.umpiresinfo = Umpireinfo
                    self.tableView.reloadData()
                }
            }
        }
        default:
            return
        }
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "Match", bundle: nil), forCellReuseIdentifier: "MatchCell")
        tableView.register(UINib(nibName: "TeamAndUmpireTableViewCell", bundle: nil), forCellReuseIdentifier: "teamAndUmpireCell")
        tableView.register(UINib(nibName: "GroundAndPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "playerAndGround")
        tableView.register(UINib(nibName: ScoreboardPointsCell.nibName, bundle: nil), forCellReuseIdentifier: ScoreboardPointsCell.identifier)
        tableView.register(UINib(nibName: StatsCell.nibName, bundle: nil), forCellReuseIdentifier: StatsCell.identifier)
    }
    
    private func registerHeader() {
        tableView.register(UINib(nibName: ScoreboardHeader.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: ScoreboardHeader.identifier)
        tableView.register(UINib(nibName: SimpleLabelHeader.nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: SimpleLabelHeader.identifier)
    }
}

extension ContainerViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch index {
        case 0: return (viewTournament.computeNumberOfSectionsRequired())
        case 3: return 2
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setNumberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch index {
        case 0: return createMatchCell(tableView: tableView, indexPath: indexPath)
        case 1: return createTeamCell(tableView: tableView, index: indexPath.row)
        case 2: return createScoreBoard(tableView: tableView, index: indexPath.row)
        case 3: return createStatCell(tableView: tableView, indexPath: indexPath)
        case 4: return createGroundCell(tableView: tableView, index: indexPath.row)
        case 5: return createUmpireCell(tableView: tableView, index: indexPath.row)
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch index {
        case 0: return 212
        case 1: return 75
        case 2: return 60
        case 3: return 60
        case 4: return 80
        case 5: return 75
        default: return 100
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch index {
        case 0:
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: SimpleLabelHeader.identifier) as! SimpleLabelHeader
            view.configureDateLabel(header: viewTournament.segrageatedMatches[section].first?.matchDate ?? "2022-12-20")
            view.backgroundColor = .clear
            return view
        case 2:
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ScoreboardHeader.identifier) as! ScoreboardHeader
            view.backgroundConfiguration?.backgroundColor = .lightGray
            return view
        case 3:
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: SimpleLabelHeader.identifier) as! SimpleLabelHeader
            if section == 0 {
                view.configure(text: "Batting")
            } else {
                view.configure(text: "Bowling")
            }
            return view
            
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if index == 0 || index == 2 || index == 3 {
            return 50
        } else {
            return 0.1
        }
    }
    
    private func setNumberOfRows(section: Int) -> Int {
        switch index {
        case 0:return viewTournament.computeNumberOfRowsInSection(section: section)
        case 1:
            return teamInfo?.count ?? 0
            
        case 2:
            return self.teamInfo?.count ?? 0
        case 3:
            if section == 0 {
                return vm?.battingStats.count ?? 0
            } else {
                return vm?.bowlingStats.count ?? 0
            }
        case 4:
            return  viewTournament.grounds.count
        case 5:
            return  umpiresinfo?.count ?? 0
        default:
            return 0
        }
    }
    
    func createTeamCell(tableView: UITableView, index: Int) ->  TeamAndUmpireTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamAndUmpireCell") as! TeamAndUmpireTableViewCell
        if let teamInfo = self.teamInfo {
            cell.setData(data: (teamInfo[index]))
        }
        return cell
    }
    
    func createMatchCell(tableView: UITableView, indexPath: IndexPath) ->  MatchCardCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell") as! MatchCardCell
        if let matchInfo = self.matchdatas{
            cell.sendVersusMatchesData(vmatch: (matchInfo[indexPath.row]))
        }
        return cell
    }
    
    func createStatCell(tableView: UITableView, indexPath: IndexPath) ->  StatsCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: StatsCell.identifier) as! StatsCell
            cell.label.text = vm?.battingStats[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: StatsCell.identifier) as! StatsCell
            cell.label.text = vm?.bowlingStats[indexPath.row]
            return cell
        }
        
    }
    
    func createScoreBoard(tableView: UITableView, index: Int) -> ScoreboardPointsCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScoreboardPointsCell.identifier) as! ScoreboardPointsCell
        cell.sendPointsTable(scores: self.teamInfo?[index])
        return cell
    }
    
    func createGroundCell(tableView: UITableView, index: Int) -> GroundAndPlayerTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerAndGround") as! GroundAndPlayerTableViewCell
        cell.setData(data: viewTournament.grounds[index])
        return cell
    }
    
    func createUmpireCell(tableView: UITableView, index: Int) -> TeamAndUmpireTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamAndUmpireCell" ) as! TeamAndUmpireTableViewCell
        cell.setData(data: viewTournament.umpires[index])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if index == 0 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LiveViewController") as? LiveViewController
            liveScoreViewModel.currentMatchId = viewTournament.matches[indexPath.row].matchId
            liveScoreViewModel.currentTournamentId = viewTournament.matches[indexPath.row].tournamentId
            if viewTournament.matches[indexPath.row].matchStatus == MatchStatus.UPCOMING.rawValue {
                liveScoreViewModel.isUpCommingMatch = true
            }
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
}

extension ContainerViewController: OverviewViewModelProtocol {
    func showFilterResponse(model: FilterResponseModel?) {
        
    }
}
