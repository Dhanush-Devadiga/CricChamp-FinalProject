//
//  TournamentContainer.swift
//  ManageSegmentCricChamps
//
//  Created by Preetam G on 21/12/22.
//

import UIKit

class TournamentContainer: UIViewController {

    // TODO: Put this in some view model
    var list: [String] = ["Teams", "Overs", "Grounds", "Umpire", "Start Date", "End Date", "Start of Play", "End of Play"]
    var numbers: [String] = ["6", "5", "4", "4", "Sat, Oct 15 2017", "Sat, Oct 16 2017", "9:00 AM", "6:00 PM"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    func registerCell() {
        tableView.register(UINib(nibName: OverViewCell.nibName, bundle: nil), forCellReuseIdentifier: OverViewCell.identifier)
    }
}

extension TournamentContainer: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OverViewCell.identifier) as! OverViewCell
        cell.setData(string: list[indexPath.row], overview: numbers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        76
    }
}
