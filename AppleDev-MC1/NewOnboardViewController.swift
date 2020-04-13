//
//  NewOnboardViewController.swift
//  AppleDev-MC1
//
//  Created by Nathanael Evan on 13/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit

class NewOnboardViewController: UIViewController {

    @IBOutlet weak var imageOnboard: UIImageView!
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var headingText: UILabel!
    @IBOutlet weak var bodyText: UILabel!
    
    var currentIndex = 0
    
    let images = ["onBoard_01", "onBoard_02", "onBoard_03"]
    
    let headings =  ["Ambience", "Track Your Progress", "Flip Focus, Improve Activity"]
    
    let bodies = [
          "Choose the sound of your surrounding to match your mood, and help reduce external distraction.",
          "History page let you track your progression. Reflect your day, or even your week with only one tap!",
          "Flip it! Turn your phone and start your activity. Get your work done efficiently" ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLoad()
        
    }
    
    @IBAction func prevButtonTapped(_ sender: UIButton) {
        
        if currentIndex == 2 {
            currentIndex -= 1
            displayPageControl()
            nextButton.setTitle("NEXT", for: .normal)
            skipButton.isHidden = false
            displayData()
        }
        else if currentIndex == 1 {
            currentIndex -= 1
            displayPageControl()
            displayData()
            prevButton.setTitle("", for: .normal)
        }
        
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        currentIndex += 1
        
        if currentIndex == 1 {
            displayData()
            displayPageControl()
            prevButton.setTitle("PREV", for: .normal)
        }
        else if currentIndex == 2 {
            nextButton.setTitle("START", for: .normal)
            displayPageControl()
            skipButton.isHidden = true
            displayData()
        }
        else{
            performSegue(withIdentifier: "navToMain", sender: self)
        }
      
        
        
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "navToMain", sender: self)
    }
    
    fileprivate func setUpLoad() {
        view.backgroundColor = .white
//        skipButton.isHidden = true
        prevButton.setTitle("", for: .normal)
        displayData()
    }
    
    fileprivate func displayData() {
        imageOnboard.image = UIImage(named: images[currentIndex])
        headingText.text = "\(headings[currentIndex])"
        bodyText.text = "\(bodies[currentIndex])"
    }
    
    fileprivate func displayPageControl() {
        pageController.currentPage = currentIndex
    }
}
