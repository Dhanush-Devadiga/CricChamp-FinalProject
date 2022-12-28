//
//  ClockViewController.swift
//  calender
//
//  Created by Preetam G on 22/12/22.
//

import UIKit

protocol TimeHandler {
    func sendAlert(title: String, message: String)
}

class ClockViewController: UIViewController {
    
    @IBOutlet weak var hourButton: UIButton!
    @IBOutlet weak var minutesButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var amLabel: UILabel!
    @IBOutlet weak var pmLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var startPlayLine: UIView!
    @IBOutlet weak var endPlayLine: UIView!
    
    @IBOutlet weak var onProceedTapped: GradientButton!
    var currentTimeType: DateSelection = .STARTDATE
    
    let viewModel = TimeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        viewModel.currentSelect = .TIME
        startTimeConfig()
        viewModel.delegate = self
        resetTimePicker()
        disableProceedButton()
        self.onProceedTapped.setUpButtonBackGround(colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.onProceedTapped.setUpButtonBackGround(colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 0)
    }
    
    @IBAction func timeValueChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        let selectedTime = timePicker.date
        let isoFormattedTime = dateFormatter.string(from: selectedTime)
        
        if currentTimeType == .STARTDATE {
            viewModel.startTime = timePicker.date
            viewModel.assignStartTimeHeaders(start: isoFormattedTime)
        } else {
            viewModel.endTime = timePicker.date
            viewModel.assignEndTimeHeaders(end: isoFormattedTime)
        }
        
        if viewModel.readyForPatch {
            enableProceedButton()
        } else {
            disableProceedButton()
        }
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        let time = timeFormatter.string(from: timePicker.date)
        let hour = time.split(separator: ":").first
        hourButton.setTitle(String(hour!), for: .normal)
        let minuteAMPM = time.split(separator: ":").last
        let minutes = minuteAMPM!.split(separator: " ").first
        minutesButton.setTitle(String(minutes!), for: .normal)
        
        let amPm = time.split(separator: " ").last
        if amPm == "AM" {
            amLabel.layer.opacity = 1
            pmLabel.layer.opacity = 0.7
        } else {
            amLabel.layer.opacity = 0.7
            pmLabel.layer.opacity = 1
        }
    }
    
    @IBAction func startTimeButtonTapped(_ sender: UIButton) {
        startTimeConfig()
        resetTimePicker()
        currentTimeType = .STARTDATE
    }
    
    @IBAction func endTimeButtonTapped(_ sender: UIButton) {
        endTimeConfig()
        resetTimePicker()
        currentTimeType = .ENDDATE
    }
    
    @IBAction func onProceedTapped(_ sender: UIButton) {
        if viewModel.readyForPatch {
            viewModel.patchDateTime { responseCode in
                DispatchQueue.main.async
                {
                    if responseCode == 200 {
                        let vc = self.storyboard?.instantiateViewController(identifier: "TournamentOverviewVC") as? TournamentOverviewVC
                        self.navigationController?.pushViewController(vc!, animated: true)
                    }
                }
            }
        }
    }
    
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func disableProceedButton() {
        onProceedTapped.isEnabled = false
        onProceedTapped.setUpButtonBackGround(colours: [#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)], cornerRadius: CGFloat(0))
    }
    
    private func enableProceedButton() {
        onProceedTapped.isEnabled = true
        onProceedTapped.setUpButtonBackGround(colours: [#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)], cornerRadius: CGFloat(0))
    }
    
    func resetTimePicker() {
        let calendar = Calendar.current
        let components = DateComponents(calendar: calendar, hour: 9, minute: 0)
        timePicker.date = calendar.date(from: components) ?? Date()
    }
    
    func startTimeConfig() {
        startButton.layer.opacity = 1
        endButton.layer.opacity = 0.7
        endPlayLine.isHidden = true
        startPlayLine.isHidden = false
    }
    
    func endTimeConfig() {
        startButton.layer.opacity = 0.7
        endButton.layer.opacity = 1
        endPlayLine.isHidden = false
        startPlayLine.isHidden = true
    }
}

extension ClockViewController: TimeHandler {
    func sendAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
