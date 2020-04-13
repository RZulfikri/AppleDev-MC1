//
//  FlipToStartVC.swift
//  AppleDev-MC1
//
//  Created by Muhammad Haidar Rais on 08/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class FlipToStartVC: UIViewController {
    @IBOutlet var infoLbl: [UILabel]!
    @IBOutlet weak var timeLeftLbl: UILabel!
    @IBOutlet weak var ambienceImg: UIImageView!
    @IBOutlet weak var swipeInfoImg: UIImageView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var motion = CMMotionManager()
    var focusTimer = Timer()
    var breakTimer = Timer()
    var isStart = false
    var breakTime = 10
    var timeRemaining = 100
    var nowHistory = History()
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        
        initView()
    }
    
    
    
    func startFocus(){
        timerStartAct()
        startSound()
    }
    
    func pauseFocus(){
        cancelBtn.setTitle("Give Up", for: .normal)
        cancelBtn.titleLabel?.text = "Give Up"
        timerPauseAct()
//        pauseSound()
    }
    
    func startSound() {
        player.play()
        player.numberOfLoops = -1
    }
    
//    func pauseSound() {
//        player.pause()
//    }
    
    func initView() {
        activateProximity(true)
        ambienceImg.image = UIImage(imageLiteralResourceName: globalAmbiences.getAmbienceAt(index: nowHistory.ambienceId!).imageName)
        timeRemaining = nowHistory.duration! * 60
        timeLeftLbl.text = "\(format(second: timeRemaining))"
        
        do {
            let audioPath = Bundle.main.path(forResource: globalAmbiences.getAmbienceAt(index: nowHistory.ambienceId!).audioName, ofType: ".mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        } catch {
            
        }
        player.prepareToPlay()
    }
    
    func timerStartAct(){
        breakTimer.invalidate()
        breakTime = 10
        focusTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(showTime), userInfo: nil, repeats: true)
    }
    
    func timerPauseAct(){
        focusTimer.invalidate()
        breakTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeView), userInfo: nil, repeats: true)
    }
    
    @objc func showTime(){
        if timeRemaining == 0 {
            completeTask()
        } else {
            timeRemaining -= 1
            timeLeftLbl.text = "\(format(second: timeRemaining))"
        }
    }
    
    @objc func changeView() {
        if breakTime == 0 {
            completeTask()
        } else {
            breakTime -= 1
        }
        infoLbl[0].text = "Turn your phone flipped down" //height 37
        infoLbl[1].text = "\(breakTime)s" //426
        infoLbl[2].text = "to continue the activity!" //430
        
        infoLbl[0].frame.size.height = 37
        infoLbl[1].frame.origin.y = 426
        infoLbl[2].frame.origin.y = 430
        
        infoLbl[1].font = infoLbl[1].font.withSize(16)
        infoLbl[1].textColor = UIColor.systemBlue
        
        swipeInfoImg.isHidden = true
    }
    
    func stopFocus(){
        player.stop()
        focusTimer.invalidate()
        breakTimer.invalidate()
        activateProximity(false)
    }
    
    func completeTask(){
        if timeRemaining == 0 {
            nowHistory.isComplete = true
            performSegue(withIdentifier: "navToCongrat", sender: self)
        } else {
            showFailureConfirmation()
        }
        stopFocus()
        globalHistory.addHistory(history: nowHistory)        
    }
    
    func activateProximity(_ stats: Bool) {
        let device = UIDevice.current
        device.isProximityMonitoringEnabled = stats
        if device.isProximityMonitoringEnabled{
            NotificationCenter.default.addObserver(self, selector: #selector(myAccelerometer), name: nil
                , object: device)
        }
    }
    
    func showCancelConfirmation() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Cancel Activity", message: "Are ayou sure want to cancel this activity?", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            self.performSegue(withIdentifier: "unwindToSetActivity", sender: self)
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "No", style: .cancel) { (_) in }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showFailureConfirmation() {
    //Creating UIAlertController and
    //Setting title and message for the alert dialog
    let alertController = UIAlertController(title: "Activity Alert", message: "You failed to complete the activity, try again?", preferredStyle: .alert)
    
    //the confirm action taking the inputs
    let confirmAction = UIAlertAction(title: "Ok", style: .default) { (_) in
        self.performSegue(withIdentifier: "unwindToSetActivity", sender: self)
    }
    
    //adding the action to dialogbox
    alertController.addAction(confirmAction)
    
    //finally presenting the dialog box
    self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func myAccelerometer(notification: NSNotification) {
        motion.accelerometerUpdateInterval = 0.5
        var isCovered = false
        if let device = notification.object as? UIDevice{
            isCovered = device.proximityState
        }
        motion.startAccelerometerUpdates(to: OperationQueue.current!){(data, error) in
//            cek x, y, z data
//            print(data as Any)
            if let trueData = data {
                self.view.reloadInputViews()
                let z = trueData.acceleration.z
                let isFaceDown = Double(z) > 0.9 ? true : false
                let isStart = isFaceDown && isCovered ? true : false
                if isStart{
                    if self.isStart != isStart {
                        self.startFocus()
                    }
                } else {
                    if self.isStart != isStart {
                        self.pauseFocus()
                    }
                }
                self.isStart = isStart
            }
        }
    }
    
    @IBAction func cancelActivity(_ sender: UIButton) {
        showCancelConfirmation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            if identifier == "unwindToSetActivity" {
                if let dest = segue.destination as? SetActivity{
                    dest.selectedDuration = nowHistory.duration!
                }
            }
        }
    }
    
}
