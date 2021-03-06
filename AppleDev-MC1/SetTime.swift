//
//  ViewController.swift
//  AppleDev-MC1
//
//  Created by Rahmat Zulfikri on 07/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit
import AVFoundation

class SetTime: UIViewController, UIScrollViewDelegate, UIPageViewControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var durationPicker: UIPickerView!
    @IBOutlet weak var startBtn: RoundButton!
    
    var slides: [Slide] = []
    var musicPlayer: AVAudioPlayer?
    var durationModelPicker: DurationModelPicker!
    var rotationAngle: CGFloat!
    var selectedDuration: Int = 0
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupScrollView()
        setupPicker()
        
    }
    
    func setupScrollView() {
        scrollView.delegate = self
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        backgroundMusic(index: 0)
    }
    
    // Setup Duration Picker
    func setupPicker() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(getSelectedDuration), name: Notification.Name("pickedDuration"), object: nil)
        
        rotationAngle = -90 * (.pi / 180)
        
        durationModelPicker = DurationModelPicker()
        durationModelPicker.modelData = ListOfDurations.getData()
        
        let height = durationPicker.frame.origin.y
        durationPicker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        durationPicker.frame = CGRect(x: -100, y: height, width: view.frame.width + 200, height: 100)

        durationPicker.delegate = durationModelPicker
        durationPicker.dataSource = durationModelPicker
    }
    
    // Setup Music Player
    func setupMusicPlayer(songTitle: String) {
        let path = Bundle.main.path(forResource: "\(songTitle).mp3", ofType: nil)
        let url = URL(fileURLWithPath: path!)
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer?.play()
        } catch {
            //Error
        }
    }
    
    // Setup Side Scroll
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    // Music Player
    func backgroundMusic(index: Int) {
        if index == 0 {
            setupMusicPlayer(songTitle: "Cyberpunk")
            titleLbl.text = "Cyberpunk"
        } else if index == 1 {
            setupMusicPlayer(songTitle: "Cafe")
            titleLbl.text = "Cafe"
        } else if index == 2 {
            setupMusicPlayer(songTitle: "Fireloop")
            titleLbl.text = "Fire"
        } else if index == 3 {
            setupMusicPlayer(songTitle: "Bird")
            titleLbl.text = "Bird"
        } else {
            setupMusicPlayer(songTitle: "Forest")
            titleLbl.text = "Forest"
        }
    }

    // Image Carousel Content
    func createSlides() -> [Slide] {
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "Cyberpunk")
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "Cafe")
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "Fire")
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.imageView.image = UIImage(named: "Bird")
        
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.imageView.image = UIImage(named: "Forest")
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    // Connect Music to background & Slide
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
            
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
            
        // Vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
            
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        //Scales the imageview on paging the scrollview
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
            
        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
                
        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
                
        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
                
        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
            slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
            slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
        }
        
        backgroundMusic(index: Int(pageIndex))
    }
    
    @objc func getSelectedDuration() {
       let indexSelectedDuration = durationPicker.selectedRow(inComponent: 0)

        
        let tempSelectedDuration = durationModelPicker.modelData[indexSelectedDuration]
        
        selectedDuration = Int(tempSelectedDuration.duration)!
    }
    
    @IBAction func startActivity(_ sender: UIButton) {
        print(selectedDuration)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

