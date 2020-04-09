//
//  ViewController.swift
//  AppleDev-MC1
//
//  Created by Rahmat Zulfikri on 07/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit
import AVFoundation

class SetTime: UIViewController, UIScrollViewDelegate, UIPageViewControllerDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var titleLbl: UILabel!
    
    var slides:[Slide] = [];
    var musicPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scrollView.delegate = self
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        backgroundMusic(index: 0)
    }
    
    func musicPlayer(songTitle: String) {
        let path = Bundle.main.path(forResource: "\(songTitle).mp3", ofType: nil)
        let url = URL(fileURLWithPath: path!)
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer?.play()
        } catch {
            //Error
        }
    }
    
    func backgroundMusic(index: Int) {
        
        if index == 0 {
            musicPlayer(songTitle: "Campfire")
            titleLbl.text = "Campfire"
        } else if index == 1 {
            musicPlayer(songTitle: "Coffee Shop")
            titleLbl.text = "Coffee Shop"
        } else if index == 2 {
            musicPlayer(songTitle: "Ocean Waves")
            titleLbl.text = "Ocean Waves"
        } else if index == 3 {
            musicPlayer(songTitle: "Thuderstorm")
            titleLbl.text = "Thunderstorm"
        } else {
            musicPlayer(songTitle: "Forest 1")
            titleLbl.text = "Forest"
        }
    }

    
    func createSlides() -> [Slide] {

        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "toa-heftiba-DUXACn8tgp4-unsplash")
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "kari-shea-2c80smWge9Y-unsplash")
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "jason-leung-andxLi4Kv8w-unsplash")
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.imageView.image = UIImage(named: "haik-ourfal-M4biGF0pN5s-unsplash")
        
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.imageView.image = UIImage(named: "deglee-degi-wQImoykAwGs-unsplash")
        
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
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
    
/*    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }*/
}

