//
//  ViewMatchPageViewController.swift
//  demoooo
//
//  Created by Preetam G on 12/12/22.
//

import UIKit

class ViewMatchPageController: UIViewController {
    var overViewViewModel: OverviewViewModel?
    var viewModel: ViewModel?
    var index: Int = 0
    var pageViewController: ViewMatchContentController?
    var swipedIndex: Int = 0
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var tournamentName: UILabel!
    @IBOutlet weak var code: UIView!
    var selectedFilter = 0
    var filterData: FilterResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ViewModel(self)
        self.viewModel?.getFilterModelMockData()
        self.pageViewController?.swipeDelegate = self
        
    }

    func selectedFilterValue(_ value: Int) {
        self.selectedFilter = value
        self.filterCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SeguePageViewController")
        {
            if let vc  = segue.destination as? ViewMatchContentController {
                self.pageViewController = vc
                //vc.swipeDelegate = self
        }
        }
    }
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
extension ViewMatchPageController: UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filterData?.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Ccell", for: indexPath) as? ViewNavCel {
            let model = self.filterData?.list?[indexPath.row]
            cell.heading.text = model?.data ?? ""
            if self.selectedFilter == indexPath.row {
                cell.heading.textColor = .white
                cell.heading.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
                cell.yellowView.backgroundColor = .yellow
                cell.yellowView.isHidden = false
            } else {
                cell.heading.textColor = .white
                cell.heading.font = UIFont.systemFont(ofSize: 12, weight: .light)
                cell.yellowView.backgroundColor = .yellow
                cell.yellowView.isHidden = true
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 130, height: 50)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedFilterValue(indexPath.row)
        self.filterCollectionView.scrollToItem(at: IndexPath(row: self.selectedFilter, section: 0), at: .centeredHorizontally, animated: true)
        self.filterCollectionView.reloadData()
        self.pageViewController?.forward(index: indexPath.row - 1)
    }
    
    
}

extension ViewMatchPageController: ViewModelProtocol {
    func showFilterData(model: FilterResponseModel?) {
        if let model = model {
            self.filterData = model
            self.filterCollectionView.reloadData()
        }
    }
}

extension ViewMatchPageController: IndexProtocol {
    func sendIndex(value: Int) {
        self.selectedFilterValue(value)
        self.swipedIndex = value
        self.filterCollectionView.scrollToItem(at: IndexPath(row: value, section: 0), at: .centeredHorizontally, animated: true)
        self.filterCollectionView.reloadData()
    }
}
