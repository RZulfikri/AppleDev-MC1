//
//  SettingActivitySectionHeader.swift
//  AppleDev-MC1
//
//  Created by Rahmat Zulfikri on 12/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit

class SettingActivitySectionHeader: UITableViewHeaderFooterView {
    let title = UILabel()
    let image = UIImageView()
    let button = UIButton()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
            self.contentView.backgroundColor = .black
            title.textColor = .white
            button.translatesAutoresizingMaskIntoConstraints = false
            title.translatesAutoresizingMaskIntoConstraints = false
            title.backgroundColor = .blue

            contentView.addSubview(image)
            contentView.addSubview(title)
        

            // Center the image vertically and place it near the leading
            // edge of the view. Constrain its width and height to 50 points.
            NSLayoutConstraint.activate([

               // Center the label vertically, and use it to fill the remaining
               // space in the header view.
               title.heightAnchor.constraint(equalToConstant: 50),
               title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                
              button.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
//                             image.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 8),
//               image.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
               button.widthAnchor.constraint(equalToConstant: 50),
               button.heightAnchor.constraint(equalToConstant: 50),
//               image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ])
       }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
