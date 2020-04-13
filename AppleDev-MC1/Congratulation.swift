//
//  Congratulation.swift
//  AppleDev-MC1
//
//  Created by Andrew Novansky Ignatius on 09/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit

class Congratulation: UIViewController {

    @IBOutlet weak var CongratsLabel: UILabel!
    @IBOutlet weak var BackToFocusButton: RoundButton!
    override func viewDidLoad() {
        super.viewDidLoad()

//        CongratsLabel.text = "You have successfully completed your activity of Working for \(minutes) minutes!"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onPressBackToMain(_ sender: UIButton) {
 self.performSegue(withIdentifier: "unwindToSetActivity", sender: self)
    }
    
}
