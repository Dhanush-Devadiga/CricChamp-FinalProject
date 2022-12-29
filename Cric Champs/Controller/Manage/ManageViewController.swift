//
//  ViewController.swift
//  ManageSegmentCricChamps
//
//  Created by Preetam G on 21/12/22.
//

import UIKit

var list: [String] = ["Teams", "Overs", "Grounds", "Umpire", "Start Date", "End Date", "Start of Play", "End of Play"]
var numbers: [String] = ["6", "5", "4", "4", "Sat, Oct 15 2017", "Sat, Oct 16 2017", "9:00 AM", "6:00 PM"]

var matches: [MatchCell] = []

var coAdmins = [CoAdmin]()

class ManageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var codeBackgroundView: UIView!
    @IBOutlet weak var tournamentLine: UIView!
    @IBOutlet weak var matchesLine: UIView!
    @IBOutlet weak var coAdminLine: UIView!
    
    var currentSelection: Selection?
    var manageVm = ManageMatchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeBackgroundView.layer.cornerRadius = 10
        registerCell()
        tableView.dataSource = self
        tableView.delegate = self
        configureTournamentSelect()
        
//        manageVm.getMatchCell { (isSuccess) in
//            DispatchQueue.main.async{ self.tableView.reloadData() }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manageVm.makeDataRequest { (_, _) in
            DispatchQueue.main.async{ self.tableView.reloadData() }
        }
    }
    
    
    func registerCell() {
        tableView.register(UINib(nibName: OverViewCell.nibName, bundle: nil), forCellReuseIdentifier: OverViewCell.identifier)
        
        tableView.register(UINib(nibName: MatchTableCell.nibName, bundle: nil), forCellReuseIdentifier: MatchTableCell.identifier)
        
        tableView.register(UINib(nibName: CoAdminCell.nibName, bundle: nil), forCellReuseIdentifier: CoAdminCell.identifier)
    }
    
    private func createTempCoAdmins() {
        coAdmins.append(CoAdmin(name: "Dhanush Devadiga", profilePhoto: nil, matches: "Match 1, Match 2, Match 3", currentMatch: "Match 2"))
    }
    
    @IBAction func onTournamentTapped(_ sender: UIButton) {
        configureTournamentSelect()
    }
    
    @IBAction func onMatchesTapped(_ sender: UIButton) {
        configureMatchesSelect()
    }
    
    @IBAction func onCoAdminTapped(_ sender: UIButton) {
        configureCoAdminsSelect()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    private func configureTournamentSelect() {
        currentSelection = .TOURNAMENT
        tournamentLine.isHidden = false
        matchesLine.isHidden = true
        coAdminLine.isHidden = true
        tableView.reloadData()
    }
    
    private func configureMatchesSelect() {
        currentSelection = .MATCHES
        tournamentLine.isHidden = true
        matchesLine.isHidden = false
        coAdminLine.isHidden = true
        tableView.reloadData()
    }
    
    private func configureCoAdminsSelect() {
        currentSelection = .COADMINS
        tournamentLine.isHidden = true
        matchesLine.isHidden = true
        coAdminLine.isHidden = false
        tableView.reloadData()
    }
}

extension ManageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        switch currentSelection {
        case .COADMINS:
            rows = coAdmins.count
        case .MATCHES:
            rows = manageVm.matches.count
//            rows = matches.count
        case .TOURNAMENT:
            rows = list.count
        case .none:
            break
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch currentSelection {
        case .COADMINS:
            let cell = tableView.dequeueReusableCell(withIdentifier: CoAdminCell.identifier) as! CoAdminCell
            let coAdmin = coAdmins[indexPath.row]
            
            cell.configureCell(name: coAdmin.name, profilePhoto: nil, matchList: coAdmin.matches, currentMatch: coAdmin.currentMatch)
            return cell
        case .MATCHES:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell") as! MatchCardCell
            cell.sendVersusMatchesData(vmatch: manageVm.matches[indexPath.row])
            return cell
        case .TOURNAMENT:
            let cell = tableView.dequeueReusableCell(withIdentifier: OverViewCell.identifier) as! OverViewCell
            cell.setData(string: list[indexPath.row], overview: numbers[indexPath.row])
            return cell
        case .none:
            let cell = tableView.dequeueReusableCell(withIdentifier: OverViewCell.identifier) as! OverViewCell
            cell.setData(string: list[indexPath.row], overview: numbers[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 0
        switch currentSelection {
        case .COADMINS:
            height = 212
            break
        case .MATCHES:
            height = 212
        case .TOURNAMENT:
            height = 70
        case .none:
            break
        }
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MatchCardCell {
            if cell.currentMatchStatus == MatchStatus.LIVE {
                let vc = self.storyboard?.instantiateViewController(identifier: UpdateLiveScoreViewController.identifier) as! UpdateLiveScoreViewController
                vc.viewModel.updateTourID(tournament: Int(manageVm.matches[indexPath.row].tournamentId))
                vc.viewModel.updateMatchID(match: Int(manageVm.matches[indexPath.row].matchId))
                vc.viewModel.updateHeaders()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

enum Selection {
    case TOURNAMENT, MATCHES, COADMINS
}
