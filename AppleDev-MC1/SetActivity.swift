//
//  SetActivity.swift
//  AppleDev-MC1
//
//  Created by Andrew Novansky Ignatius on 09/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit
import AVFoundation
class SetActivity: UIViewController, UIScrollViewDelegate, UITabBarControllerDelegate {
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
    var musicPlayer: AVAudioPlayer!
    var durationModelPicker: DurationModelPicker!
    var rotationAngle: CGFloat!
    var selectedDuration: Int = 0

    var nowHistory = History()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tabBarController?.delegate = self
        setup()
    }
    
    func setup() {
        selectedActivityIndex = 0
        selectedAmbienceIndex = 0
        slides = []
        
        if selectedDuration == 0 {
            selectedDuration = 1
        }
        
        // hide duration picker first
        containerActivity.isHidden = false
        containerDuration.isHidden = true
        
        // set corner
        let rectShapeCA = CAShapeLayer()
        rectShapeCA.bounds = self.containerActivity.frame
        rectShapeCA.position = self.containerActivity.center
        rectShapeCA.path = UIBezierPath(roundedRect: self.containerActivity.bounds, byRoundingCorners: [.topRight , .topLeft], cornerRadii: CGSize(width: 50, height: 50)).cgPath
        self.containerActivity.layer.mask = rectShapeCA
        
        let rectShapeCD = CAShapeLayer()
        rectShapeCD.bounds = self.containerDuration.frame
        rectShapeCD.position = self.containerDuration.center
        rectShapeCD.path = UIBezierPath(roundedRect: self.containerDuration.bounds, byRoundingCorners: [.topRight , .topLeft], cornerRadii: CGSize(width: 50, height: 50)).cgPath
        self.containerDuration.layer.mask = rectShapeCD
                
        activityLabel.text = globalActivities.getItemAt(index: selectedActivityIndex)
        
        setupScrollView()
        setupPicker()
    }
    
    func setupScrollView() {
        scrollView.delegate = self
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        scrollView.contentInsetAdjustmentBehavior = .never
        
        scrollView.setContentOffset(.zero, animated: true)
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
        if (segue.identifier == "navToFlip") {
            if let flipToStartVC = segue.destination as? FlipToStartVC {
                flipToStartVC.nowHistory = History(ambienceId: globalAmbiences.getSelectedAmbienceIndexAt(index: selectedAmbienceIndex).id, activityName: globalActivities.getItemAt(index: selectedActivityIndex), date: Date(), duration: selectedDuration, isComplete: false)
                flipToStartVC.hidesBottomBarWhenPushed = true
            }
        }
    }
    
    @IBAction func unwindToSetActivity(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        setup()
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
            slide.imageView.contentMode = .scaleAspectFill
            slide.imageView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            arrSlide.append(slide)
        }
 
        return arrSlide
    }
    
    // Setup Side Scroll
     func setupSlideScrollView(slides : [Slide]) {
         scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(slides.count), height: scrollView.frame.height)
         scrollView.isPagingEnabled = true
         
         for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: scrollView.frame.width * CGFloat(i), y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
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
        
        let itemLengthInPercent: CGFloat = CGFloat(1.0 / CGFloat(globalAmbiences.getAmbienceList().count - 1))
        
        for i in 0 ..< globalAmbiences.getAmbienceList().count - 1 {
            let min = itemLengthInPercent * CGFloat(i)
            let max = itemLengthInPercent * CGFloat(CGFloat(i) + 1.0)
            if (percentOffset.x > CGFloat(min) && percentOffset.y <= CGFloat(max)) {
                let firstScaleX = (max-percentOffset.x)/itemLengthInPercent
                let firstScaleY = 0.0
                let secondScaleX = percentOffset.x/max
                let secondScaleY = 0.0
                slides[i].imageView.transform = CGAffineTransform(translationX: firstScaleX, y: CGFloat(firstScaleY))
                slides[i + 1].imageView.transform = CGAffineTransform(translationX: secondScaleX, y: CGFloat(secondScaleY))
            }
        }

        selectedAmbienceIndex = Int(pageIndex)
        setupMusicPlayer(songTitle: globalAmbiences.getSelectedAmbienceIndexAt(index: Int(pageIndex)).audioName!)
     }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let nc = viewController as? UINavigationController {
            let activity = nc.viewControllers[0]
//            if let settingActivity = activity as? SettingsVC {
//                print("SETTING ACTIVITY")
//            }
            
            if let activity = activity as? SetActivity {
                activity.setup()
            }
            
            if let history = activity as? HistoryTVC {
                history.tableView.reloadData()
            }
        }
    }
}
