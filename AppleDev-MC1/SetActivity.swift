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
    
    var i = 0
    var slides:[Slide] = []
    var activity:[String] = globalActivities.arrActivities
    var musicPlayer: AVAudioPlayer?

    var nowHistory = History()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupScrollView()
    }
    
    func setupScrollView() {
        scrollView.delegate = self
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        setupMusicPlayer(songTitle: globalAmbiences.getSelectedAmbienceIndexAt(index: 0).audioName!)
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
            i += 1
            if (i >= globalActivities.getCount()) {
                i = 0
            }
            activityLabel.text = globalActivities.getItemAt(index: i)
        case prevButton:
            i -= 1
            if (i <= 0) {
                i = globalActivities.getCount() - 1
            }
            activityLabel.text = globalActivities.getItemAt(index: i)
        default:
            activityLabel.text = globalActivities.getItemAt(index: 0)
        }
    }
    

   // Image Carousel Content
    func createSlides() -> [Slide] {
        var arrSlide: [Slide] = []
        
        for ambience in globalAmbiences.getSelectedAmbiences() {
            print(ambience)
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
         
        setupMusicPlayer(songTitle: globalAmbiences.getSelectedAmbienceIndexAt(index: Int(pageIndex)).audioName!)
     }
}
