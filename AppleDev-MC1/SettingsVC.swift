//
//  SettingsViewController.swift
//  AppleDev-MC1
//
//  Created by Rahmat Zulfikri on 08/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var segmentedCtrl: UISegmentedControl!
    @IBOutlet weak var contentContainer: UIView!
    
    var settingsActivityVC: UIView!
    var settingsAmbienceVC: UIView!
    
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentIndex = segmentedCtrl.selectedSegmentIndex
        setupLayoutContent()
        changeScreenByIndex(index: currentIndex)
    }
    
    func setupLayoutContent() {
        settingsActivityVC = SettingsActivityVC().view
        settingsAmbienceVC = SettingsAmbienceVC().view
           
        settingsActivityVC.frame = contentContainer.bounds
        settingsActivityVC.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       print(contentContainer.bounds)
        settingsAmbienceVC.frame = contentContainer.bounds
        settingsAmbienceVC.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       
        contentContainer.addSubview(settingsActivityVC)
        contentContainer.addSubview(settingsAmbienceVC)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func changeScreenByIndex(index: Int) {
        if (index == 0) {
            contentContainer.bringSubviewToFront(settingsActivityVC)
        } else {
            contentContainer.bringSubviewToFront(settingsAmbienceVC)
        }
    }

    @IBAction func onSegmentedChange(_ sender: UISegmentedControl) {
        currentIndex = sender.selectedSegmentIndex
        changeScreenByIndex(index: currentIndex)
    }
}
