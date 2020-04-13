//
//  SetActivity.swift
//  AppleDev-MC1
//
//  Created by Andrew Novansky Ignatius on 09/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit
import AVFoundation
class SetActivity: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pickDuration: RoundButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet var startActivityButton: RoundButton!
    @IBOutlet var durationPicker: UIPickerView!
    
    @IBOutlet var containerActivity: UIView!
    @IBOutlet var containerDuration: UIView!
    
    var selectedActivityIndex = 0
    var selectedAmbienceIndex = 0
    var slides:[Slide] = []
    var activity:[String] = globalActivities.arrActivities
    var musicPlayer: AVAudioPlayer?
    var durationModelPicker: DurationModelPicker!
    var rotationAngle: CGFloat!
    var selectedDuration: Int = 0

    var nowHistory = History()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // hide duration picker first
        containerDuration.isHidden = true
        
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
        
        setupMusicPlayer(songTitle: globalAmbiences.getSelectedAmbienceIndexAt(index: selectedAmbienceIndex).audioName!)
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
        
        if ((musicPlayer?.isPlaying) != nil) {
            musicPlayer?.stop()
        }
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer?.play()
        } catch  {
            //Error
            print("MUSIC PLAYER ERROR")
        }
    }
    
    
    
    @IBAction func PrevNextButton(_ sender: UIButton) {
        switch sender {
        case nextButton:
            selectedActivityIndex += 1
            if (selectedActivityIndex >= globalActivities.getCount()) {
                selectedActivityIndex = 0
            }
            activityLabel.text = globalActivities.getItemAt(index: selectedActivityIndex)
        case prevButton:
            selectedActivityIndex -= 1
            if (selectedActivityIndex <= 0) {
                selectedActivityIndex = globalActivities.getCount() - 1
            }
            activityLabel.text = globalActivities.getItemAt(index: selectedActivityIndex)
        default:
            activityLabel.text = globalActivities.getItemAt(index: 0)
        }
    }
    
    @objc func getSelectedDuration() {
       let indexSelectedDuration = durationPicker.selectedRow(inComponent: 0)

        
        let tempSelectedDuration = durationModelPicker.modelData[indexSelectedDuration]
        
        selectedDuration = Int(tempSelectedDuration.duration)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let flipToStartVC = segue.description as? FlipToStartVC {
            flipToStartVC.nowHistory = History(ambienceId: globalAmbiences.getSelectedAmbienceIndexAt(index: selectedAmbienceIndex).id, activityName: globalActivities.getItemAt(index: selectedActivityIndex), date: Date(), duration: selectedDuration, isComplete: false)
        }
    }
    
    @IBAction func onPressStart(_ sender: UIButton) {
        performSegue(withIdentifier: "navToFlip", sender: self)
    }
    
    @IBAction func onPressPickDuration(_ sender: UIButton) {
        containerActivity.isHidden = true
        containerDuration.isHidden = false
    }
    
   // Image Carousel Content
    func createSlides() -> [Slide] {
        var arrSlide: [Slide] = []
        
        for ambience in globalAmbiences.getSelectedAmbiences() {
            let slide:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide.imageView.image = UIImage(named: ambience.imageName)
            arrSlide.append(slide)
        }
 
        return arrSlide
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
         
        selectedAmbienceIndex = Int(pageIndex)
        setupMusicPlayer(songTitle: globalAmbiences.getSelectedAmbienceIndexAt(index: Int(pageIndex)).audioName!)
     }
}
