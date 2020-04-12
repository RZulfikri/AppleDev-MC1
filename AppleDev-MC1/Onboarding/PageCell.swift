//
//  PageCell.swift
//  AppleDev-MC1
//
//  Created by Nathanael Evan on 10/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit



class PageCell: UICollectionViewCell {
    
    var page : Page? {
        didSet{
            guard let unwrappedPage = page else {return}
            
            onboardImageView.image = UIImage(named: unwrappedPage.imageName)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
            
            attributedText.append(NSAttributedString(string: "\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor.darkGray]))
            
            headingTextView.attributedText = attributedText
            headingTextView.textAlignment = .center
        }
    }
    
    private let onboardImageView : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "onBoard_02"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let headingTextView : UITextView = {
       let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Track Your Progress", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        
        attributedText.append(NSAttributedString(string: "\n\nHistory page let you track your progression. Reflect your day, or even your week with only one tap!", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor.darkGray]))
        
        textView.attributedText = attributedText

        textView.textAlignment = .center
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
   
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        setUpLayout()
    }
    
    private func setUpLayout() {
        let topImageContainerView = UIView()
        addSubview(topImageContainerView)

        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8 ).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        

        topImageContainerView.addSubview(onboardImageView)
        
        onboardImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        onboardImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        onboardImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true

    
        addSubview(headingTextView)
        headingTextView.topAnchor.constraint(equalTo: onboardImageView.bottomAnchor).isActive = true
        headingTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        headingTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        headingTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
     
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
