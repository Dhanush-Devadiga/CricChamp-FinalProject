//
//  ViewController.swift
//  UpdateLiveScore
//
//  Created by Preetam G on 11/12/22.
//

import UIKit

protocol Handler {
    func overDidEndHandler()
    func showAlert(title: String, message: String)
    func showBowlerSelection()
}

class UpdateLiveScoreViewController: UIViewController {
    
    static let identifier = "UpdateLiveScoreViewController"
    
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var batsmanButton: UIButton!
    @IBOutlet weak var bowlerButton: UIButton!
    @IBOutlet weak var swapButton: UIButton!
    @IBOutlet weak var zeroRun: LiveScoreCustomRunButton!
    @IBOutlet weak var oneRun: LiveScoreCustomRunButton!
    @IBOutlet weak var twoRun: LiveScoreCustomRunButton!
    @IBOutlet weak var threeRun: LiveScoreCustomRunButton!
    @IBOutlet weak var fourRun: LiveScoreCustomRunButton!
    @IBOutlet weak var sixRun: LiveScoreCustomRunButton!
    var runButtons: [LiveScoreCustomRunButton] = []
    
    @IBOutlet weak var wideButton: LiveScoreCustomRunButton!
    @IBOutlet weak var noBall: LiveScoreCustomRunButton!
    @IBOutlet weak var byesButton: LiveScoreCustomRunButton!
    @IBOutlet weak var legByeButton: LiveScoreCustomRunButton!
    var extrasButtons: [LiveScoreCustomRunButton] = []
    
    @IBOutlet weak var hitWicket: CustomWicketButton!
    @IBOutlet weak var stumped: CustomWicketButton!
    @IBOutlet weak var runOutButton: CustomWicketButton!
    @IBOutlet weak var bowledButton: CustomWicketButton!
    @IBOutlet weak var other: CustomWicketButton!
    @IBOutlet weak var caught: CustomWicketButton!
    @IBOutlet weak var lbwButton: CustomWicketButton!
    var wicketButtons: [CustomWicketButton] = []
    
    var wideButtonGroup: [LiveScoreCustomButton] = []
    var noBallButtonGroup: [LiveScoreCustomButton] = []
    var byesButtonGroup: [LiveScoreCustomButton] = []
    var legByesButtonGroup: [LiveScoreCustomButton] = []
    
    var buttonGroup: [LiveScoreCustomButton] = []
    var selectedButtons: [LiveScoreCustomButton] = []
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var dynamicStatusView: UIView!
    @IBOutlet weak var staticStatusView: UIView!
    @IBOutlet weak var wicketLabel: UILabel!
    @IBOutlet weak var extraLabel: UILabel!
    @IBOutlet weak var runLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var runsScoredLabel: UILabel!
    @IBOutlet weak var oversLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var choosePlayerLabel: UILabel!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var runsView: UIView!
    @IBOutlet weak var wicketsView: UIView!
    @IBOutlet weak var chooseFielderView: UIView!
    @IBOutlet weak var chooseFielderTable: UITableView!
    @IBOutlet weak var chooseReasonTableView: UITableView!
    @IBOutlet weak var stopMatchView: UIView!
    @IBOutlet weak var chooseReasonView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var gradientButton: GradientButton!
    
    let viewModel = UpdateLiveScoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureButtons()
        hideStopReasonView()
        addTableViewTags()
        self.activityIndicator.hidesWhenStopped = true
        
        activityIndicator.startAnimating()
        if viewModel.firstLoad {
            viewModel.getTeams() { statusCode in
                if statusCode != 200 {
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                } else {
                    self.viewModel.getAllTeamPlayersForBothTeams { (response) in
                        if response == 200 {
                            self.updateStatusLabels()}
                        if self.viewModel.firstLoad{self.initialAlert()}
                    }
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
    
    private func configureButtons() {
        _ = self.gradientButton.applyGradient( colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 4)
        wideButtonGroup = [lbwButton, bowledButton, caught, sixRun]
        noBallButtonGroup = [bowledButton, lbwButton, caught]
        byesButtonGroup = [bowledButton, lbwButton, caught, sixRun]
        legByesButtonGroup = [bowledButton, lbwButton, caught, sixRun]
        
        buttonGroup.append(contentsOf: runButtons)
        buttonGroup.append(contentsOf: wicketButtons)
        buttonGroup.append(contentsOf: extrasButtons)
        shouldAllowUpdate()
    }
    
    private func configure() {
        viewModel.delegate = self
        self.runButtons = [zeroRun, oneRun, twoRun, threeRun, fourRun, sixRun]
        self.extrasButtons = [wideButton, noBall, byesButton, legByeButton]
        
        self.wicketButtons = [hitWicket, stumped, runOutButton, bowledButton, other, caught, lbwButton]
        
        dynamicStatusView.isHidden = true
        chooseFielderView.isHidden = true
        stopMatchView.isHidden = true
        hideStopMatch()
        chooseFielderTable.delegate = self
        chooseFielderTable.dataSource = self
        chooseReasonTableView.delegate = self
        chooseReasonTableView.dataSource = self
        chooseFielderView.layer.cornerRadius = 20
    }
    
    func initialAlert() {
        let alert = UIAlertController(title: "Admin Config", message: "Please select the striker, non-striker bowler(Initial random default values assigned)", preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in self.viewModel.firstLoad = false}))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addTableViewTags() {
        chooseFielderTable.tag = 1
        chooseReasonTableView.tag = 2
    }
    
    @IBAction func onSwapTapped(_ sender: UIButton) {
        viewModel.swapInnings()
        updateStatusLabels()
    }
    
    @IBAction func onBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bowlerTapped(_ sender: UIButton) {
        activityIndicator.startAnimating()
        viewModel.changePlayerList(selection: SelectionType.BOWLER) {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
            self.showChoosePlayerView(player: "Bowler")
        }
    }
    
    @IBAction func batsmanTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Batsman Selection", message: "Please select the striker and non-striker (Initial random default values assigned)", preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        alert.addAction(UIAlertAction(title: "Striker", style: .default, handler: { (alertAction) in
            self.showStrikerSelection()
        }))
        alert.addAction(UIAlertAction(title: "Non-Striker", style: .default, handler: { (alertAction) in
            self.showNonStrikerSelection()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
            DispatchQueue.main.async {
                self.buttonGroup.forEach { (button) in
                    button.deselectButton()
                }}
        }))
        self.present(alert, animated: true, completion: nil)
        
        activityIndicator.startAnimating()
        viewModel.changePlayerList(selection: SelectionType.STRIKER) {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
        }
    }
    
    @IBAction func onRunTapped(_ sender: LiveScoreCustomRunButton) {
        showDynamicStatusView()
        viewModel.updateRunLabelText(with: sender.title(for: .normal) ?? "0")
        viewModel.updateScore(run: Int(sender.title(for: .normal) ?? "0") ?? 0)
        updateStatusLabels()
        sender.changeButtonsStatus(sender: sender, buttons: runButtons)
    }
    
    @IBAction func onExtraTapped(_ sender: LiveScoreCustomRunButton) {
        viewModel.updateExtraLabelText(with: sender.title(for: .normal) ?? "Wide")
        showDynamicStatusView()
        if let extra = (sender.titleLabel?.text) {
            switch extra.lowercased() {
            case "wd": viewModel.updateExtra(extra: ExtraType.wide)
            case "nb": viewModel.updateExtra(extra: ExtraType.noBall)
            case "bye": viewModel.updateExtra(extra: ExtraType.bye)
            case "lb": viewModel.updateExtra(extra: ExtraType.legBye)
            default: viewModel.updateExtra(extra: ExtraType.wide)
            }
        }
        updateStatusLabels()
        sender.changeButtonsStatus(sender: sender, buttons: extrasButtons)
        checkExtraButtonRules(buttonTitle: sender.title(for: .normal) ?? "lb")
    }
    
    @IBAction func onWicketTapped(_ sender: CustomWicketButton) {
        viewModel.updateWicketLabelText(with: sender.title(for: .normal) ?? "Hit Wicket")
        sender.changeButtonsStatus(sender: sender, buttons: wicketButtons)
        makeExtraZero()
        updateStatusLabels()
        checkWicketRules(buttonTitle: sender.title(for: .normal) ?? "other")
        switch sender.title(for: .normal)?.lowercased() ?? "other" {
        case "hit wicket": viewModel.currentlyWicketTypeSelected = WicketType.HITWICKET; print("hit wicket")
        case "stumped": viewModel.currentlyWicketTypeSelected = WicketType.STUMPED; print("stumped")
        case "run out": viewModel.currentlyWicketTypeSelected = WicketType.RUNOUT; print("run out")
        case "bowled": viewModel.currentlyWicketTypeSelected = WicketType.BOWLED; print("bowled")
        case "lbw": viewModel.currentlyWicketTypeSelected = WicketType.LBW; print("lbw")
        case "caught": viewModel.currentlyWicketTypeSelected = WicketType.CAUGHT; print("caught")
        case "other": viewModel.currentlyWicketTypeSelected = WicketType.OTHERS; print("other")
        default:
            viewModel.currentlyWicketTypeSelected = WicketType.OTHERS
        }
        wicketHandler()
    }
    
    @IBAction func updateButton(_ sender: Any) {
        updateStatusLabels()
        if let wicket = viewModel.currentlyWicketTypeSelected {
            guard let nextBatID = viewModel.newBatsmanId, let currentOutID = viewModel.currentOutPlayerID else { showAlert(title: "Insufficient Info", message: "When a wicket falls please select the player who got out, next batsmen")
                return
            }
            if wicket == .RUNOUT || wicket == .CAUGHT || wicket == .STUMPED {
                if viewModel.feilderId == nil {
                    showAlert(title: "Insufficient Info", message: "Make sure fielder/wicket keeper selected")
                    return
                }
            } else {
                viewModel.feilderId = viewModel.bowlerId
            }
            
            viewModel.updateWicket(wicket: wicket, outplayerId: currentOutID, bowler: viewModel.bowlerId, feilder: viewModel.feilderId, newBatsmanId: nextBatID)
        }
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        viewModel.callUpdateLiveScoreAPI {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.updateStatusLabels()
                self.view.isUserInteractionEnabled = true
            }
        }
        showStaticStatusView()
        refresh()
        viewDidLoad()
    }
    
    @IBAction func onOptionsButtonTapped(_ sender: UIButton) {
        showStopMatchView()
    }
    
    @IBAction func optionCancelTap(_ sender: Any) {
        hideChoosePlayerView()
        updateStatusLabels()
        wicketButtons.forEach{ button in
            button.deselectButton()
        }
    }
    
    @IBAction func onStopMatchtapped(_ sender: UIButton) {
        showStopReasonView()
    }
    
    @IBAction func onReasonCancel(_ sender: UIButton) {
        hideStopReasonView()
    }
    
    @IBAction func optionsCancelTap(_ sender: UIButton) {
        hideStopMatch()
    }
    
    func changeBowler() {
        if viewModel.doesNeedBowlerSelection {
            activityIndicator.startAnimating()
            viewModel.changePlayerList(selection: SelectionType.BOWLER) {
                DispatchQueue.main.async{
                    self.activityIndicator.stopAnimating()
                    self.showChoosePlayerView(player: "Bowler")
                }
                self.viewModel.reasonSelction = false
            }
            
        }
    }
    
    func showStrikerSelection() {
        activityIndicator.startAnimating()
        viewModel.changePlayerList(selection: SelectionType.STRIKER) {
            self.viewModel.batsmanSelection = true
            DispatchQueue.main.async{
                self.activityIndicator.stopAnimating()
                self.showChoosePlayerView(player: "Striker")
            }
        }
    }
    
    func showNonStrikerSelection() {
        activityIndicator.startAnimating()
        viewModel.changePlayerList(selection: SelectionType.NONSTRIKER) {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
            self.viewModel.nonStrikerSelection = true
            DispatchQueue.main.async{self.showChoosePlayerView(player: "Non-Striker")}
        }
        
    }
    
    func showBowlerSelection() {
        activityIndicator.startAnimating()
        viewModel.changePlayerList(selection: SelectionType.BOWLER) {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
            self.viewModel.bowlerSelection = true
            DispatchQueue.main.async{self.showChoosePlayerView(player: "Bowler")}
        }
    }
    
    func nextBatsmanSelection() {
        viewModel.updateNextBatsmen(player: 0)
        activityIndicator.startAnimating()
        viewModel.changePlayerList(selection: SelectionType.NEXTBATSMAN) {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
            self.viewModel.nextBatsmanSelection = true
            DispatchQueue.main.async{self.showChoosePlayerView(player: "Next Batsman")}
        }
    }
    
    func showOutPlayerSelection() {
        activityIndicator.startAnimating()
        viewModel.changePlayerList(selection: SelectionType.CURRENTWICKET) {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
            self.viewModel.currentBatsmanSelection = true
            DispatchQueue.main.async{self.showChoosePlayerView(player: "Current Wicket")}
        }
    }
    
    func fielderSelection() {
        activityIndicator.startAnimating()
        viewModel.changePlayerList(selection: SelectionType.FEILDER) {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
            self.viewModel.nextBatsmanSelection = true
            DispatchQueue.main.async{self.showChoosePlayerView(player: "Fielder")}
        }
    }
    
    func updateStatusLabels() {
        wicketLabel.text = viewModel.wicketLabelText
        extraLabel.text = viewModel.extraLabelText
        runLabel.text = viewModel.runLabelText
        descriptionLabel.text = viewModel.descriptionLabelText
        runsScoredLabel.text = viewModel.runLabelText
        scoreLabel.text = viewModel.scoreLabelText
        oversLabel.text = viewModel.oversLabelText
        batsmanButton.setTitle(viewModel.batsman, for: .normal)
        bowlerButton.setTitle(viewModel.bowler, for: .normal)
    }
    
    func showStopReasonView() {
        hideStopMatch()
        chooseReasonView.isHidden = false
        updateButton.isEnabled = false
        chooseReasonTableView.isUserInteractionEnabled = true
        scrollContentView.isUserInteractionEnabled = false
        scrollContentView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        scrollContentView.layer.opacity = 0.1
    }
    
    func hideStopReasonView() {
        chooseReasonView.isHidden = true
        updateButton.isEnabled = true
        chooseReasonTableView.isUserInteractionEnabled = false
        scrollContentView.isUserInteractionEnabled = true
        scrollContentView.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        scrollContentView.layer.opacity = 1
        chooseReasonTableView.reloadData()
    }
    
    func showChoosePlayerView(player: String) {
        DispatchQueue.main.async {
            self.choosePlayerLabel.text = "Choose \(player)"
            self.chooseFielderTable.reloadData()
            self.chooseFielderView.isHidden = false
            self.updateButton.isEnabled = false
            self.chooseFielderView.isUserInteractionEnabled = true
            self.scrollContentView.isUserInteractionEnabled = false
            self.scrollContentView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.scrollContentView.layer.opacity = 0.1
        }
    }
    
    func hideChoosePlayerView() {
        chooseFielderView.isHidden = true
        updateButton.isEnabled = true
        chooseFielderView.isUserInteractionEnabled = false
        scrollContentView.isUserInteractionEnabled = true
        scrollContentView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        scrollContentView.layer.opacity = 1
        chooseFielderTable.reloadData()
    }
    
    func showStaticStatusView() {
        chooseFielderTable.reloadData()
        staticStatusView.reloadInputViews()
        staticStatusView.isHidden = false
        dynamicStatusView.isHidden = true
    }
    
    func showDynamicStatusView() {
        dynamicStatusView.reloadInputViews()
        staticStatusView.isHidden = true
        dynamicStatusView.isHidden = false
    }
    
    func checkExtraButtonRules(buttonTitle: String) {
        switch buttonTitle.lowercased() {
        case "wd":
            wideButtonGroup.forEach { (button) in
                button.isEnabled = false
            }
        case "nb":
            noBallButtonGroup.forEach { (button) in
                button.isEnabled = false
            }
        case "bye":
            byesButtonGroup.forEach { (button) in
                button.isEnabled = false
            }
        default:
            buttonGroup.forEach { (button) in
                button.isEnabled = true
            }
        }
    }
    
    func makeRunZeroOnWicket() {
        viewModel.updateScore(run: 0)
        updateStatusLabels()
        zeroRun.changeButtonsStatus(sender: zeroRun, buttons: runButtons)
        runButtons.forEach { (button) in
            if button.title(for: .normal) != "0" {
                button.isEnabled = false
            }
        }
    }
    
    func makeFourSixDisabledOnRunOut() {
        viewModel.updateScore(run: 0)
        updateStatusLabels()
        zeroRun.changeButtonsStatus(sender: zeroRun, buttons: runButtons)
        runButtons.forEach { (button) in
            if button.title(for: .normal) == "4" ||  button.title(for: .normal) == "6" {
                button.isEnabled = false
            } else {
                button.isEnabled = true
            }
        }
    }
    
    func checkWicketRules(buttonTitle: String) {
        switch buttonTitle.lowercased() {
        case "run out": makeFourSixDisabledOnRunOut()
        case "hit wicket": makeRunZeroOnWicket()
        case "bowled": makeRunZeroOnWicket()
        case "stumped": makeRunZeroOnWicket()
        case  "lbw": makeRunZeroOnWicket()
        case "caught": makeRunZeroOnWicket()
        default: break
        }
    }
    
    func makeExtraZero() {
        extrasButtons.forEach { $0.deselectButton(); $0.isEnabled = false}
        viewModel.makeExtraDeselect()
        updateStatusLabels()
    }
    
    func showStopMatchView() {
        stopMatchView.isHidden = false
        scrollContentView.isUserInteractionEnabled = false
        scrollContentView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        scrollContentView.layer.opacity = 0.2
        updateButton.isEnabled = false
    }
    
    func hideStopMatch() {
        stopMatchView.isHidden = true
        scrollContentView.isUserInteractionEnabled = true
        scrollContentView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        scrollContentView.layer.opacity = 1
        updateButton.isEnabled = true
    }
    
    func refresh() {
        selectedButtons.removeAll()
        buttonGroup.forEach {
            $0.deselectButton()
            $0.isEnabled = true
        }
        swapButton.isEnabled = false
        swapButton.isHidden = true
        viewModel.refresh()
    }
    
    func shouldAllowUpdate() {
        if viewModel.shouldAllowUpdate() {
            self.updateButton.isEnabled = true
        } else {
            self.updateButton.isEnabled = false
        }
    }
    
    func wicketHandler() {
        let alert = UIAlertController(title: "Provide Information", message: "Please select the current player who got out, incoming batsman and fielder if applicable", preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
//        viewModel.updateCurrentOutPlayer(player: viewModel.strikerBatsmanId)
        let currentOutBatsmanSelect = UIAlertAction(title: "Current Wicket", style: .default) { (_) in
            self.showOutPlayerSelection()
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(currentOutBatsmanSelect)
        let nextbatsmanSelect = UIAlertAction(title: "Incomming Batsman", style: .default) { (_) in
            self.nextBatsmanSelection()
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(nextbatsmanSelect)
        if viewModel.currentlyWicketTypeSelected == .STUMPED || viewModel.currentlyWicketTypeSelected == .CAUGHT || viewModel.currentlyWicketTypeSelected == .RUNOUT {
            let fielderAction = UIAlertAction(title: "Fielder", style: .default) { (_) in
                self.fielderSelection()
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(fielderAction)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UpdateLiveScoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return viewModel.listPlayers.count
        } else {
            return viewModel.reasons.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChooseFeilderCell
            cell.configure(with: viewModel.listPlayers[indexPath.row].playerName)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReasonCell.identifier, for: indexPath) as! ReasonCell
            cell.configure(reason: viewModel.reasons[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hideChoosePlayerView()
        
        if viewModel.batsmanSelection {
            viewModel.batsman = viewModel.listPlayers[indexPath.row].playerName
            viewModel.strikerBatsmanId = viewModel.listPlayers[indexPath.row].playerId
        } else if viewModel.bowlerSelection {
            viewModel.bowlerId = viewModel.listPlayers[indexPath.row].playerId
            viewModel.bowler = viewModel.listPlayers[indexPath.row].playerName
        } else if viewModel.fielderSelection {
            viewModel.fielder = viewModel.listPlayers[indexPath.row].playerName
            viewModel.updateFielder(player: viewModel.listPlayers[indexPath.row].playerId)
        } else if viewModel.reasonSelction {
            viewModel.currentReason = viewModel.reasons[indexPath.row]
        } else if viewModel.nonStrikerSelection {
            viewModel.nonStrikerBatsmanId = viewModel.listPlayers[indexPath.row].playerId
        } else if viewModel.nextBatsmanSelection {
            viewModel.updateNextBatsmen(player: viewModel.listPlayers[indexPath.row].playerId)
            updateStatusLabels()
        } else if viewModel.currentBatsmanSelection {
            viewModel.updateCurrentOutPlayer(player: viewModel.listPlayers[indexPath.row].playerId)
        } else {
            print("none did select")
        }
        
        shouldAllowUpdate()
        updateStatusLabels()
    }
}

extension UpdateLiveScoreViewController: Handler {
    
    func overDidEndHandler() {
        self.showBowlerSelection()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        if viewModel.currentMatchStatus == MatchStatus.COMPLETED {
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (_) in
                self.navigationController?.popViewController(animated: true)
            }))
        } else {
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
