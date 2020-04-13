//
//  FlipToStartVC.swift
//  AppleDev-MC1
//
//  Created by Muhammad Haidar Rais on 08/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit
import CoreMotion

class FlipToStartVC: UIViewController {
    struct ambie {
        var gambar : String
        var musik : String
    }
    @IBOutlet weak var timeLeftLbl: UILabel!
    
    var motion = CMMotionManager()
    var timer = Timer()
    var isFaceDown = false
    var time = 0
    var timeRemaining = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activateProximity(true)
//        myAccelerometer()
//        timerStartAct()
//        Do any additional setup after loading the view.
    }
    
    func startFocus(){
        timerStartAct()
    }

//    show for debugg
//    @objc func proximityChanged(notification: NSNotification) {
//        if let device = notification.object as? UIDevice{
//            print("proximity \(device.proximityState)")
//        }
//    }
//    start and pause proximity monitor
//    true for turn on
    
    func activateProximity(_ stats: Bool) {
        let device = UIDevice.current
        device.isProximityMonitoringEnabled = stats
        if device.isProximityMonitoringEnabled{
            NotificationCenter.default.addObserver(self, selector: #selector(myAccelerometer), name: nil , object: device)
        }
    }
    
    func timerStartAct(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(showTime), userInfo: nil, repeats: true)
    }
    
    func timerPauseAct(){
        timer.invalidate()
    }
    
    @objc func showTime(){
        timeRemaining -= 1
        timeLeftLbl.text = "\(format(second: timeRemaining))"
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
//                self.timeLeftLbl.text = stats
                if (self.isFaceDown != isFaceDown){
                    print(isFaceDown)
                    if isCovered {
                        if isFaceDown {
                            self.startFocus()
                        }
                    } else {
                        self.timerPauseAct()
                    }
                    self.isFaceDown = isFaceDown
                }
            }
        }
    }
    
    @IBAction func cancelActivity(_ sender: UIButton) {
        
    }
}

func format(second: Int) -> String {
    let m = second / 60
    let s = second % 60
    return "\(m.padZero()):\(s.padZero())"
}

private extension Int {
    func padZero() -> String {
        return String(format: "%02d", self)
    }
}
