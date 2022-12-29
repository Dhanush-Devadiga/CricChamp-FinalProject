//
//  LiveMatchContentViewController.swift
//  LiveScoreProject
//
//  Created by Dhanush Devadiga on 16/12/22.
//

import UIKit

class LiveMatchContentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var index = 0
    var liveScoreViewModel = LiveScoreViweMdoel.shared
    var scoreBoardViewModel = ScoreBoardViewModel.shared
    var isTeamListShown = false
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        registerCell()
        registerHeader()
        scheduledTimerWithTimeInterval()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func scheduledTimerWithTimeInterval(){
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
    }
    
    @objc func refreshData() {
        loadData()
    }
    
    private func loadData() {
        if index == 0 {
            liveScoreViewModel.getMatchInfo { (liveScore, error) in
                DispatchQueue.main.async
                {
                    if liveScore != nil {
                        self.tableView.reloadData()
                    }
                }
            }
        } else if !liveScoreViewModel.isUpCommingMatch {
            if index == 1 {
                liveScoreViewModel.makeDataRequest { (liveScore, error) in
                    DispatchQueue.main.async
                    {
                        if liveScore != nil {
                            self.tableView.reloadData()
                        }
                    }
                }
            } else if index == 2 {
                //            let parameters: [String: Any] = ["tournamentId" : "\(String(describing: liveScoreViewModel.currentTournamentId))", "matchId": "\(String(describing: liveScoreViewModel.currentMatchId))", "teamId": "\(String(describing: liveScoreViewModel.currentMatchInfo?.teamOneId))"]
                let parameters: [String: Any] = ["tournamentId": "93", "matchId": "24", "teamId": "118"]
                scoreBoardViewModel.makeDataRequest(parameters: parameters) { (scoreBoard, error) in
                    DispatchQueue.main.async
                    {
                        if self.scoreBoardViewModel.scoreBoard != nil {
                            self.tableView.reloadData()
                        }
                        
                    }
                    
                }
            }
        }
        
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "LiveScoreCell", bundle: nil), forCellReuseIdentifier: "liveScoreCell")
        tableView.register(UINib(nibName: "BatsmanScoreCell", bundle: nil), forCellReuseIdentifier: "batsmanScoreCell")
        tableView.register(UINib(nibName: "BowlerScoreCell", bundle: nil), forCellReuseIdentifier: "bowlerScoreCell")
        tableView.register(UINib(nibName:"PartnershipCell", bundle: nil), forCellReuseIdentifier: "partnershipCell")
        tableView.register(UINib(nibName:"RecentBallCell", bundle: nil), forCellReuseIdentifier: "recentBallCell")
        tableView.register(UINib(nibName:"CommentaryCell", bundle: nil), forCellReuseIdentifier: "commentaryCell")
        tableView.register(UINib(nibName: "MatchInfoCell", bundle: nil), forCellReuseIdentifier: "infoCell")
        tableView.register(UINib(nibName: "TeamAndUmpireTableViewCell", bundle: nil), forCellReuseIdentifier: "teamAndUmpireCell")
        tableView.register(UINib(nibName: "VenueCell", bundle: nil), forCellReuseIdentifier: "venueCell")
        tableView.register(UINib(nibName: "PlayerBoard", bundle: nil), forCellReuseIdentifier: "PlayerboardTableViewCell")
        tableView.register(UINib(nibName: "Extras", bundle: nil), forCellReuseIdentifier: "ExtrasTableViewCell")
        tableView.register(UINib(nibName: "Total", bundle: nil), forCellReuseIdentifier: "TotalTableViewCell")
        tableView.register(UINib(nibName: "FallOfWicketCell", bundle: nil), forCellReuseIdentifier: "FallOfWicketTableViewCell")
        tableView.register(UINib(nibName: "TeamNameTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamNameTableViewCell")
        tableView.register(UINib(nibName: "EndOfOverCell", bundle: nil), forCellReuseIdentifier: "EndOfOverCell")

    }
    
    private func registerHeader() {
        tableView.register(UINib(nibName:"BatsmanHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "BatsmanHeaderView")
        tableView.register(UINib(nibName:"BowlerHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "BowlerHeaderView")
        tableView.register(UINib(nibName:"TeamScoreHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "TeamScoreHeaderView")
        tableView.register(UINib(nibName:"CommentaryHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "CommentaryHeader")
        tableView.register(UINib(nibName: "FallOfWicketHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "FallOfWicketHeader")
        tableView.register(UINib(nibName: "ScoreBoardTeamScoreHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "ScoreBoardTeamScoreHeader")
    }
    
 }
  
 extension LiveMatchContentViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.setNumberOfSectionForIndex()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.getNumberOfRowsInSectionForIndex(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch index {
        case 0: return setDataForInfoTable(indexPath: indexPath)
        case 1: return setDataForLiveScoreTable(indexPath: indexPath)
        case 2: return setDataForScoreBoardTable(indexPath: indexPath)
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self.getViewForHeaderInSectionForIndex(section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if index == 2 && indexPath.section == 0 {
            guard let parameters = liveScoreViewModel.fetchRequiredIdToGetScore(index: indexPath.row) else {
                return
            }
            scoreBoardViewModel.makeDataRequest(parameters: parameters) { (scoreBoard, error) in
                DispatchQueue.main.async
                {
                    if self.scoreBoardViewModel.scoreBoard != nil {
                        self.tableView.reloadData()
                    }
                }
            }
            self.isTeamListShown = !isTeamListShown
            self.tableView.reloadData()
        }
    }
    
    
    private func setNumberOfSectionForIndex() -> Int {
        switch index {
        case 0: return 3
        case 1: if liveScoreViewModel.isUpCommingMatch {
                    return 1
                } else {
                    return 4
                }
        case 2: if liveScoreViewModel.isUpCommingMatch {
                    return 1
                } else {
                    return 4
                }
        case 3: return 1
        default:
                return 1
        }
    }
    
    private func getNumberOfRowsInSectionForIndex(section: Int) -> Int{
        switch index {
            case 0: return getNumberOfRowsInSectionForInfoTable(section: section)
            case 1: return getNumberOfRowsInSectionForLiveTable(section: section)
            case 2: return getNumberOfRowsInSectionForScoreBoard(section: section)
            case 3: return 1
            default:
                return 1
        }
    }
    
    private func getNumberOfRowsInSectionForLiveTable(section: Int) -> Int{
        switch  section {
        case 0: if liveScoreViewModel.isUpCommingMatch {
            return 0
        } else {
            return 1
        }
        case 1: if let livescore = liveScoreViewModel.liveScore {
                        return livescore.batting.count
                } else {
                    return 0
                }
        case 2: return 3
        case 3: if let livescore = liveScoreViewModel.liveScore {
                return livescore.commentary.count
                } else {
                    return 0
                }
        default:
            return 0
        }
    }
    
    private func getNumberOfRowsInSectionForInfoTable(section: Int) -> Int{
        switch section {
        case 0 : return 2
        case 1 : return 1
        case 2 : return 1
        default:
            return 0
        }
    }
    
    private func getNumberOfRowsInSectionForScoreBoard(section: Int) -> Int {
        switch section {
        case 0 : if liveScoreViewModel.isUpCommingMatch {
                    return 0
                } else {
                    if isTeamListShown {
                        return 2
                    } else {
                        return 0
                     }
                }
        case 1 : if let scoreBoard = scoreBoardViewModel.scoreBoard {
                 let rows = scoreBoard.batting.count + 2
                 return rows
                 } else {
                    return 0
                 }
        case 2 : return 1
        case 3 : return scoreBoardViewModel.scoreBoard?.bowling.count ?? 0
        default:
            return 0
        }
    }
    
    private func getViewForHeaderInSectionForIndex(section: Int) -> UIView {
        switch index {
            case 0: return getViewForHeaderInSectionForInfoTable(section: section)
            case 1: return getViewForHeaderInSectionForLiveTable(section: section)
            case 2: return getViewForHeaderInSectionForScoreBoard(section: section)
            case 4: return UIView()
            default: return UIView()
        }
    }
    
    private func getViewForHeaderInSectionForLiveTable(section: Int) -> UIView{
        switch  section {
        case 0:
            if liveScoreViewModel.isUpCommingMatch {
                    let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
                    let label = CustomHeader().getHeadetTitle(frame: view.frame, text: "Match Not Yet Started!")
                    view.addSubview(label)
                    return view
                } else {
                    let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TeamScoreHeaderView") as!           TeamScoreHeaderView
                    if let liveScore = liveScoreViewModel.liveScore, liveScore.score.count >= 1 {
                            headerview.setData(team: liveScore.score[liveScore.score.count - 1])
                    } else {
                        headerview.setDefaultValue()
                    }
                    return headerview
                }
            
        case 1: let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: "BatsmanHeaderView") as! BatsmanHeader
                return headerview
        case 2: let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: "BowlerHeaderView") as! BowlerHeaderView
                return headerview
        case 3: let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CommentaryHeader") as! CommentaryHeader
                return headerview
        default:return UIView()
        }
    }
    
    private func getViewForHeaderInSectionForInfoTable(section: Int) -> UIView {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9450980392, blue: 0.9568627451, alpha: 1)
        switch  section {
        case 0: let label = CustomHeader().getHeadetTitle(frame: headerView.frame, text: "TEAM")
                headerView.addSubview(label)
                return headerView
        case 1: let label = CustomHeader().getHeadetTitle(frame: headerView.frame, text: "INFO")
                headerView.addSubview(label)
                headerView.addSubview(label)
                return headerView
        case 2: let label = CustomHeader().getHeadetTitle(frame: headerView.frame, text: "VENUE")
                headerView.addSubview(label)
                headerView.addSubview(label)
                return headerView
        default:return UIView()
        }
    }
    
    private func getViewForHeaderInSectionForScoreBoard(section: Int) -> UIView{
        switch  section {
        case 0: if liveScoreViewModel.isUpCommingMatch {
                    let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
                    let label = CustomHeader().getHeadetTitle(frame: view.frame, text: "Match Not Yet Started")
                    view.addSubview(label)
                    return view
                } else {
                    let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ScoreBoardTeamScoreHeader") as! ScoreBoardTeamScoreHeader
                    headerview.delegate = self
                    if let data = scoreBoardViewModel.scoreBoard {
                        headerview.setScore(data: data.scoreBoard)
                    }
                return headerview
        }
        case 1: let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: "BatsmanHeaderView") as! BatsmanHeader
                return headerview
        case 2: let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FallOfWicketHeader")
                return headerview!
        case 3: let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: "BowlerHeaderView") as! BowlerHeaderView
                return headerview
        default:return UIView()
        }
    }
    
    private func setDataForLiveScoreTable(indexPath: IndexPath) -> UITableViewCell{
        if let liveScore = liveScoreViewModel.liveScore {
            switch  indexPath.section {
            case 0: if !liveScoreViewModel.isUpCommingMatch {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "liveScoreCell") as? LiveScoreCell
                    var inningStatus = false
                    if liveScore.score.count == 1 {
                        inningStatus = true
                    }
                        if liveScore.score.count >= 1 {
                            cell?.setData(team: liveScore.score[0], inningsStatus: inningStatus)
                            return cell!
                        } else {
                            return UITableViewCell()
                        }
                    }
                
            case 1: if liveScore.batting.count > 0 { let cell = tableView.dequeueReusableCell(withIdentifier: "batsmanScoreCell") as?   BatsmanScoreCell
                        cell?.setBatsmanData(batsman: liveScore.batting[indexPath.row])
                    return cell!
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "batsmanScoreCell") as? BatsmanScoreCell
                        cell?.setDefaultData()
                    return cell!
                    }
            case 2: switch indexPath.row {
                        case 0: let cell = tableView.dequeueReusableCell(withIdentifier: "bowlerScoreCell") as? BowlerScoreCell
                            cell?.setBowlerData(bowler: liveScore.bowling ?? nil)
                                return cell!
                        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: "partnershipCell") as? PartnershipCell
                                cell?.setPartnershipData(partnership: liveScore.partnership, fallOfWicket: liveScore.fallOfWicket)
                                return cell!
                        case 2: let cell = tableView.dequeueReusableCell(withIdentifier: "recentBallCell") as? RecentBallCell
                            cell?.recent = liveScore.commentary
                            cell?.recentCollectionView.reloadData()
                                return cell!
                        default: return UITableViewCell()
                    }
            case 3: if liveScore.commentary[indexPath.row].ballStatus == BallStatus.over.rawValue {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "EndOfOverCell") as? EndOfOverCell
                        cell?.over.text = String(liveScore.commentary[indexPath.row].over)
                        return cell!
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "commentaryCell") as? CommentaryCell
                        cell?.setCommentary(commentary: liveScore.commentary[indexPath.row])
                        return cell!
                    }
            default:
                return UITableViewCell()
            }
        } else {
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    private func setDataForInfoTable(indexPath: IndexPath) -> UITableViewCell{
        switch indexPath.section {
        case 0: if let cell = tableView.dequeueReusableCell(withIdentifier: "teamAndUmpireCell") as? TeamAndUmpireTableViewCell {
            if indexPath.row == 0 {
                cell.setMatchInfo(teamName: liveScoreViewModel.currentMatchInfo?.teamOne ?? "TEAM")
            } else {
                cell.setMatchInfo(teamName: liveScoreViewModel.currentMatchInfo?.teamTwo ?? "TEAM")
            }
                return cell
        }
        case 1: if let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as? MatchInfoCell {
            cell.setData(data: liveScoreViewModel.currentMatchInfo)
                return cell
        }
        case 2: if let cell = tableView.dequeueReusableCell(withIdentifier: "venueCell") as? VenueCell {
                cell.setData(data: liveScoreViewModel.currentMatchInfo)
                return cell
        }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    private func setDataForScoreBoardTable(indexPath: IndexPath) -> UITableViewCell{
        if let scoreBoard = scoreBoardViewModel.scoreBoard {
            switch indexPath.section {
            case 0: if isTeamListShown {
                        if let cell = tableView.dequeueReusableCell(withIdentifier: "TeamNameTableViewCell") as? TeamNameTableViewCell{
                            cell.setTeamName(data: liveScoreViewModel.versus[indexPath.row])
                        return cell
                        }
                    } else {
                            return UITableViewCell()
                        }
            case 1: if indexPath.row == scoreBoard.batting.count{
                        if let cell = tableView.dequeueReusableCell(withIdentifier: "ExtrasTableViewCell") as? ExtrasTableViewCell{
                            cell.setExtraScoreData(extraRun: scoreBoard.extraRuns)
                        return cell
                        }
                    } else if indexPath.row == scoreBoard.batting.count + 1 {
                        if let cell = tableView.dequeueReusableCell(withIdentifier: "TotalTableViewCell") as? TotalTableViewCell{
                            cell.setData(data: scoreBoard.scoreBoard?.score ?? 0)
                        return cell
                        }
                    } else {
                        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerboardTableViewCell") as? PlayerboardTableViewCell{
                        cell.setPlayerData(batsManData: (scoreBoard.batting[indexPath.row]))
                        return cell
                        }
                    }
            case 2: if let cell = tableView.dequeueReusableCell(withIdentifier: "FallOfWicketTableViewCell") as? FallOfWicketTableViewCell {
                    cell.setFallOfWicketData(data: scoreBoard.fallOfWicket!)
                    return cell
            }
            case 3: if let cell = tableView.dequeueReusableCell(withIdentifier: "bowlerScoreCell") as? BowlerScoreCell {
                cell.setBowlerData(bowler: scoreBoard.bowling[indexPath.row])
                return cell
            }
            default:
                return UITableViewCell()
            }
            
        }
        return UITableViewCell()
    }
 }

extension LiveMatchContentViewController: SetUpDropDown {
    func displayTeam() {
        self.isTeamListShown = !isTeamListShown
        tableView.reloadData()
    }
}
