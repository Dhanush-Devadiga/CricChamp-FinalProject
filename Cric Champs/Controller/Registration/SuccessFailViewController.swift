//
//  SuccessFailViewController.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 07/12/22.
//

import UIKit

class SuccessFailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var messageTitle: UILabel!
    @IBOutlet weak var messageSubTitle: UILabel!
    @IBOutlet weak var messageDescription: UILabel!
    @IBOutlet weak var createTournament: GradientButton!
    
    var didSuccessfullyRegister: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTournament.setUpButtonBackGround( colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 0)

        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createTournament.setUpButtonBackGround( colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 0)
    }
    
    func configure() {
        if didSuccessfullyRegister {
            createTournament.isHidden = false
            createTournament.isEnabled = true
            image.image = #imageLiteral(resourceName: "AwesomeBall")
            messageTitle.text = "Awesome!!"
            messageSubTitle.text = "You have Successfully Registered."
            messageDescription.text = "Kindly open the verification email we sentto your registered email ID and verifyyour account."
        } else {
            image.image = #imageLiteral(resourceName: "Oopsball")
            messageTitle.text = "Oops!!"
            messageSubTitle.text = "Something went wrong."
            createTournament.isHidden = true
            createTournament.isEnabled = false
            messageDescription.text = "Kindly check if all the details entered byyou are proper. If problem persists then check back after sometime."
        }
    }
    @IBAction func onBackTapped(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeViewController.self) {
                self.navigationController!.popToViewController(controller, animated: false)
                break
            }
        }
    }
    
    @IBAction func onClickCreateTournament(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateTournamentViewController") as? CreateTournamentViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
}
