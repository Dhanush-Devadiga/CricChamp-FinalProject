//
//  RecentBallCell.swift
//  ManageViewController
//
//  Created by Dhanush Devadiga on 15/12/22.
//

import UIKit

class RecentBallCell: UITableViewCell {
    var recent: [Commentary]?
    var index = 0
    var isOverComplete = false
    
    @IBOutlet weak var recentCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        recentCollectionView.delegate = self
        recentCollectionView.dataSource = self
        recentCollectionView.register(UINib(nibName: "RecentBallStatusCell", bundle: nil), forCellWithReuseIdentifier: "recentBallstatus")
    }
}

extension RecentBallCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let recent = recent {
            return recent.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let recent = recent {
        let cell = recentCollectionView.dequeueReusableCell(withReuseIdentifier: "recentBallstatus", for: indexPath) as? RecentBallStatusCell
        cell?.setRecentBallStatus(ballStatus: recent[indexPath.row - index].ballStatus, run: recent[indexPath.row - index].run)
        return cell!
    } else {
        return UICollectionViewCell()
    }
    }
    
    
}
