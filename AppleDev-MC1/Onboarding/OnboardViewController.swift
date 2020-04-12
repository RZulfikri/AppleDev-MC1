//
//  OnboardViewController.swift
//  AppleDev-MC1
//
//  Created by Nathanael Evan on 09/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit

class OnboardViewController: UIViewController {
    
    let onboardImageView : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "onBoard_01"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
    
        return imageView
    }()
    
    let headingTextView : UITextView = {
       let textView = UITextView()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedText = NSMutableAttributedString(string: "Track Your Progress", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        
        attributedText.append(NSAttributedString(string: "\n\nHistory page let you track your progression. Reflect your day, or even your week with only one tap!", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor.darkGray]))
        
        textView.attributedText = attributedText
        
//        textView.text = "Track Your Progress"
//        textView.font = UIFont.boldSystemFont(ofSize: 16)
        textView.textAlignment = .center
        textView.isEditable = false
        return textView
    }()
    
    private let previousButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.darkGray, for: .normal)
        return button
    }()
    
    private let nextButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .systemBlue
        pc.pageIndicatorTintColor = .lightGray
        return pc
        
    }()
    
// MARK: - begin
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        setUpButtomControls()

    }
    
    private func setUpLayout() {
        let topImageContainerView = UIView()
//        topImageContainerView.backgroundColor = .blue
        view.addSubview(topImageContainerView)

        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8 ).isActive = true
//      Try not to use left and right anchor
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        

        topImageContainerView.addSubview(onboardImageView)
        topImageContainerView.addSubview(headingTextView)
        
        onboardImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        onboardImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        onboardImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
//        onboardImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        onboardImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 247).isActive = true
//        onboardImageView.widthAnchor.constraint(equalToConstant: 414).isActive = true
//        onboardImageView.heightAnchor.constraint(equalToConstant: 302).isActive = true
//        imageView.frame = CGRect(x: 0, y: 0, width: 414, height: 302)
       
        headingTextView.topAnchor.constraint(equalTo: onboardImageView.bottomAnchor).isActive = true
        headingTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        headingTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        headingTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    fileprivate func setUpButtomControls() {
        
//        view.addSubview(previousButton)
//        previousButton.frame = CGRect(x: 100, y: 400, width: 200, height: 50)
//        previousButton.backgroundColor = .red
//
//        let yellowView = UIView()
//        yellowView.backgroundColor = .yellow
        
//        let greenView = UIView()
//        greenView.backgroundColor = .green
        
//        let blueView = UIView()
//        blueView.backgroundColor = .blue
        
        let bottomControlsStackView = UIStackView(arrangedSubviews:
            [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        view.addSubview(bottomControlsStackView)
        
//    Another way to activate constraint anchor
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    

    

}
