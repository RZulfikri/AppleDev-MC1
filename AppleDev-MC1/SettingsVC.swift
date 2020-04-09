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
    @IBOutlet var contentContainer: UIView!
    
    var settingsActivityVC: UIViewController!
    var settingsAmbienceVC: UIViewController!
    
    var currentIndex: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentIndex = segmentedCtrl.selectedSegmentIndex
        setupLayoutContent()
    }
    
    func setupLayoutContent() {
        
        settingsActivityVC = SettingsActivityVC()
        settingsAmbienceVC = SettingsAmbienceVC()
           
//        settingsActivityVC.frame = contentContainer.bounds
//        settingsActivityVC.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        settingsAmbienceVC.frame = contentContainer.bounds
//        settingsAmbienceVC.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        settingsActivityVC.view.frame = contentContainer.bounds
        settingsActivityVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        settingsActivityVC.didMove(toParent: self)
        contentContainer.addSubview(settingsActivityVC.view)

        settingsAmbienceVC.view.frame = contentContainer.bounds
        settingsAmbienceVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        settingsAmbienceVC.didMove(toParent: self)
        contentContainer.addSubview(settingsAmbienceVC.view)
        
        changeScreenByIndex(index: currentIndex)
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
            contentContainer.bringSubviewToFront(settingsActivityVC.view)
        } else {
            contentContainer.bringSubviewToFront(settingsAmbienceVC.view)
        }
    }

    @IBAction func onSegmentedChange(_ sender: UISegmentedControl) {
        currentIndex = sender.selectedSegmentIndex
        changeScreenByIndex(index: currentIndex)
    }
}
