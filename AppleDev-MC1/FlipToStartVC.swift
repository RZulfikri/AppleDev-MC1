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
    
    @IBOutlet weak var timeLeftLbl: UILabel!
    
    var motion = CMMotionManager()
    var timer = Timer()
    var stats = ""
    var timeRemaining = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myAccelerometer()
        timerStartAct()
        // Do any additional setup after loading the view.
    }
    
    func timerStartAct(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(showTime), userInfo: nil, repeats: true)
    }
    
    func timerPauseAct(){
        timer.invalidate()
    }
    
    @objc func showTime(){
        timeRemaining -= 1
        timeLeftLbl.text = "\(timeRemaining)"
    }
    
    func myAccelerometer() {
        motion.accelerometerUpdateInterval = 0.5
        motion.startAccelerometerUpdates(to: OperationQueue.current!){(data, error) in
            print(data as Any)
            if let trueData = data {
                self.view.reloadInputViews()
                let z = trueData.acceleration.z
                let stats = Double(z) > 0.9 ? "Kebawah" : "Keatas"
                self.timeLeftLbl.text = stats
                if (self.stats != stats){
                    print(stats)
                    self.stats = stats
                }
            }
        }
    }
    
    @IBAction func cancelActivity(_ sender: UIButton) {
        
    }
}
