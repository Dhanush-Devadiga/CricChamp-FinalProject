//
//  ViewController.swift
//  LiveScoreProject
//
//  Created by Dhanush Devadiga on 16/12/22.
//

import UIKit

class LiveViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
    var liveViewModel = LiveScoreViweMdoel.shared
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var teams: UILabel!
    var timer: Timer?
    enum LiveMenuTitles: String, CaseIterable {
        case info = "INFO"
        case live = "LIVE"
        case scoreboard = "SCOREBOARD"
        case graph = "GRAPH"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setValueForTeams()
        
    }
    
    private func setValueForTeams() {
        if let match = liveViewModel.currentMatchInfo {
            teams.text = match.teamOne + " Vs " + match.teamTwo
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "liveMenuCell", for: indexPath) as?  LiveMenuCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.menuTitle.text = LiveMenuTitles.allCases[indexPath.row].rawValue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: collectionView.frame.height)
    }
   

    @IBAction func didTapBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

