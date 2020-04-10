//
//  OnboardSwipingController.swift
//  AppleDev-MC1
//
//  Created by Nathanael Evan on 10/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit

class OnboardSwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       
        coordinator.animate(alongsideTransition: { (_) in self.collectionViewLayout.invalidateLayout()
            if self.pageControl.currentPage == 0 {
                self.collectionView.contentOffset = .zero
            }
            else{
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            
            
        }) { (_) in
            
        }
    }
    
    let imageNames = ["onBoard_01","onBoard_02","onBoard_03"]
    let headerStrings = ["Ambience", "Track Your Progress", "Flip Focus, Improve Activity"]
    
    let pages = [
        Page(imageName: "onBoard_01", headerText: "Ambience", bodyText: "Choose the sound of your surrounding to match your mood, and help reduce external distraction."),
        Page(imageName: "onBoard_02", headerText: "Track Your Progress", bodyText: "History page let you track your progression. Reflect your day, or even your week with only one tap!"),
        Page(imageName: "onBoard_03", headerText: "Flip Focus, Improve Activity", bodyText: "Flip it! Turn your phone and start your activity. Get your work done efficiently")
    ]
    
    private let previousButton : UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("", for: .normal)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
           button.setTitleColor(.darkGray, for: .normal)
           button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
           return button
       }()
       
        @objc private func handlePrev(){
            let nextIndex = max(pageControl.currentPage - 1, 0)
            let indexPath = IndexPath(item: nextIndex, section: 0)
            pageControl.currentPage = nextIndex
            collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            if pageControl.currentPage != 2 {
                nextButton.setTitle("NEXT", for: .normal)
            }
            if pageControl.currentPage == 0 {
                previousButton.setTitle("", for: .normal)
            }
        }
            
       private let nextButton : UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("NEXT", for: .normal)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
           button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
           return button
       }()
    
        @objc private func handleNext(){
            let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
            let indexPath = IndexPath(item: nextIndex, section: 0)
            pageControl.currentPage = nextIndex
            collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            if pageControl.currentPage == 2 {
                nextButton.setTitle("START", for: .normal)
            }
            else {
                nextButton.setTitle("NEXT", for: .normal)
            }
            if pageControl.currentPage == 1 {
                previousButton.setTitle("PREV", for: .normal)
            }
        }
       
       lazy var pageControl: UIPageControl = {
           
           let pc = UIPageControl()
           pc.currentPage = 0
           pc.numberOfPages = pages.count
           pc.currentPageIndicatorTintColor = .systemBlue
           pc.pageIndicatorTintColor = .lightGray
           return pc
           
       }()
    
    fileprivate func setUpButtomControls() {
         let bottomControlsStackView = UIStackView(arrangedSubviews:
             [previousButton, pageControl, nextButton])
         bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
         bottomControlsStackView.distribution = .fillEqually
         view.addSubview(bottomControlsStackView)

         NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
             bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
         ])

     }
       
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
        print(pageControl.currentPage)
        
        if pageControl.currentPage == 2 {
            nextButton.setTitle("START", for: .normal)
        }
        else if pageControl.currentPage == 0 {
            previousButton.setTitle("", for: .normal)
             nextButton.setTitle("NEXT", for: .normal)
        }
        else if pageControl.currentPage == 1 {
            previousButton.setTitle("PREV", for: .normal)
             nextButton.setTitle("NEXT", for: .normal)
        }
      
        
        
        
//        print(x, view.frame.width, x / view.frame.width)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtomControls()
        collectionView?.backgroundColor = .white
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cellid")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        cell.page = page
        
        
//        cell.onboardImageView.image = UIImage(named: page.imageName)
//        cell.headingTextView.text = page.headerText

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
        
        
    }
    
}


