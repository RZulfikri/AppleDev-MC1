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
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var PageControl: UIPageControl!
    @IBOutlet weak var PickDuration: RoundButton!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var PrevButton: UIButton!
    @IBOutlet weak var ActivityLabel: UILabel!
    
    var i = 0
    var slides:[Slide] = []
    var activity:[String] = globalActivities.arrActivities
    var player: AVAudioPlayer = AVAudioPlayer()
    var nowHistory = History()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ScrollView.delegate = self
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        PageControl.numberOfPages = slides.count
        PageControl.currentPage = 0
        view.bringSubviewToFront(PageControl)
        
        do{
            let audioPath = Bundle.main.path(forResource: globalAmbiences.getAmbienceAt(index: PageControl.currentPage).audioName, ofType: ".mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch{
            //ERROR
        }
        player.play()
        player.numberOfLoops = -1
        
    }
    
    
    @IBAction func PrevNextButton(_ sender: UIButton) {
        
        switch sender {
        case NextButton:
            i += 1
            if (i >= activity.count) {
                i = 0
            }
            ActivityLabel.text = activity[i]
        case PrevButton:
            i -= 1
            if (i <= 0) {
                i = activity.count - 1
            }
            ActivityLabel.text = activity[i]
        default:
            ActivityLabel.text = activity[0]
        }
    }
    
    
//    override func prepare(for segue: ActivityToDuration, sender: Any?) {
//        var nowHistory = History(ambienceId: globalAmbiences.getAmbienceAt(index: PageControl.currentPage).id, activityName: activity[i], duration: <#T##Int?#>, isComplete: <#T##Bool#>)
//    }
    func createSlides() -> [Slide] {
        
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: globalAmbiences.getAmbienceAt(index:0).imageName)
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: globalAmbiences.getAmbienceAt(index:1).imageName)
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: globalAmbiences.getAmbienceAt(index:2).imageName)
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.imageView.image = UIImage(named: globalAmbiences.getAmbienceAt(index:3).imageName)
        
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.imageView.image = UIImage(named: globalAmbiences.getAmbienceAt(index:4).imageName)
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        ScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        ScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        ScrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            ScrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        PageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        
        /*
         * below code changes the background color of view on paging the scrollview
         */
        //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
        
        
        /*
         * below code scales the imageview on paging the scrollview
         */
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
    }}
