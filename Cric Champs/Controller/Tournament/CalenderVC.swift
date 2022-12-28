//
//  CalenderVC.swift
//  calender
//
//  Created by Preetam G on 23/12/22.
//

import UIKit

class CalenderVC: UIViewController {
    
    @IBOutlet weak var year: UIButton!
    @IBOutlet weak var dateLabel: UIButton!
    @IBOutlet weak var startDate: UIButton!
    @IBOutlet weak var endDate: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var endDateLine: UIView!
    @IBOutlet weak var startDateLine: UIView!
    @IBOutlet weak var proceedButton: GradientButton!
    
    let viewModel = TimeViewModel()
    var currentDateType: DateSelection = .STARTDATE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        datePicker.datePickerMode = .date
    }
    
    func configure() {
        viewModel.currentSelect = .DATE
        startDateConfig()
        viewModel.delegate = self
        resetDatePicker()
        disableProceedButton()
        self.proceedButton.setUpButtonBackGround(colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 0)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.proceedButton.setUpButtonBackGround(colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 0)
    }
    
    @IBAction func onDateValueChanged(_ sender: UIDatePicker) {
        
        updateUI(date: datePicker.date)
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "YYYY-MM-dd"
        let isoFormattedDate = dateFormater.string(from: datePicker.date)
        print(dateFormater.string(from: datePicker.date))
        
        if currentDateType == .STARTDATE {
            viewModel.startDate = datePicker.date
            viewModel.assignStartDateHeaders(start: isoFormattedDate)
        } else {
            viewModel.endDate = datePicker.date
            viewModel.assignEndDateHeaders(end: isoFormattedDate)
        }
        
        if viewModel.readyForPatch {
            enableProceedButton()
        } else {
            disableProceedButton()
        }
    }
    
    func updateUI(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE/dd/MMM/yyyy"
        
        let dateSubString = (dateFormatter.string(from: datePicker.date)).split(separator: "/")
        let dateStrings = dateSubString.map { String($0) }
        year.setTitle(dateStrings.last ?? "2022", for: .normal)
        dateLabel.setTitle("\(dateStrings.first ?? "Wed"), \(dateStrings[2] ) \(dateStrings[1] )", for:  .normal)
    }
    
    @IBAction func startDateButtonTapped(_ sender: UIButton) {
        startDateConfig()
        resetDatePicker()
        currentDateType = .STARTDATE
    }
    
    @IBAction func endDateButtonTapped(_ sender: UIButton) {
        endDateConfig()
        resetDatePicker()
        currentDateType = .ENDDATE
    }
    
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onProceedTapped(_ sender: Any) {
        if viewModel.readyForPatch {
            viewModel.patchDateTime { responseCode in
                DispatchQueue.main.async {
                    if responseCode == 200 {
                        let vc = self.storyboard?.instantiateViewController(identifier: "ClockViewController") as? ClockViewController
                        self.navigationController?.pushViewController(vc!, animated: true)
                    }
                }
            }
        }
    }
    
    private func disableProceedButton() {
        proceedButton.isEnabled = false
        proceedButton.setUpButtonBackGround(colours: [#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)], cornerRadius: CGFloat(0))
    }
    
    private func enableProceedButton() {
        proceedButton.isEnabled = true
        proceedButton.setUpButtonBackGround(colours: [#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)], cornerRadius: CGFloat(0))
    }
    
    func resetDatePicker() {
        
        
        datePicker.date = Date()
    }
    
    func startDateConfig() {
        startDate.layer.opacity = 1
        endDate.layer.opacity = 0.7
        endDateLine.isHidden = true
        startDateLine.isHidden = false
    }
    
    func endDateConfig() {
        startDate.layer.opacity = 0.7
        endDate.layer.opacity = 1
        endDateLine.isHidden = false
        startDateLine.isHidden = true
    }
}

extension CalenderVC: TimeHandler {
    func sendAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
