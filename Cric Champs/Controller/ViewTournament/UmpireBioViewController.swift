//
//  UmpireBioViewController.swift
//  Cricket
//
//  Created by Preetam G on 10/12/22.
//

import UIKit

class UmpireBioViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var customProfileView: ProfilePhotoImageView!
    @IBOutlet weak var triangleView: TriangleView!
    @IBOutlet weak var profileImage: CustomImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.setCornerRadius()
        configureButtons()
        customProfileView.setRadius()
    }
    
    func configureButtons() {

    }
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
    @IBAction func onDeleteButtonClick(_ sender: Any) {
    }
    
}
