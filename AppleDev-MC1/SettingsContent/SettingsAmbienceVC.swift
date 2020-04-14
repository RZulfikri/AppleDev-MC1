//
//  SettingsAmbienceVC.swift
//  AppleDev-MC1
//
//  Created by Rahmat Zulfikri on 08/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit

class SettingsAmbienceVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let HORIZONTAL_LAYOUT_MARGIN: Float = 36

    let cellIdentifier = "ambienceCell"
    let sectionIdentifier = "ambienceSectionHeader"
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        self.collectionView.layoutMargins.left = CGFloat(HORIZONTAL_LAYOUT_MARGIN)
        self.collectionView.layoutMargins.right = CGFloat(HORIZONTAL_LAYOUT_MARGIN)
        self.collectionView.register(UINib(nibName: "AmbienceCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView.register(UINib(nibName: "SettingAmbienceSectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionIdentifier)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
 
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionIdentifier, for: indexPath) as? SettingAmbienceSectionHeader {
                sectionHeader.label.text = "Your Ambience List"
                  return sectionHeader
              }
          default:
              assert(false, "Unexpected element kind")
          }
          return UICollectionReusableView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return globalAmbiences.getAmbienceList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AmbienceCell
        
        let currentAmbience = globalAmbiences.getAmbienceAt(index: indexPath.row)
        cell.image.image = UIImage(named: currentAmbience.imageName)
        cell.image.frame = cell.bounds
        cell.iconCross.frame = cell.bounds
                
        if (currentAmbience.selected) {
            cell.iconCross.isHidden = false
        } else {
            cell.iconCross.isHidden = true
        }
                  
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (view.frame.width - (12 * 2)) - (CGFloat(HORIZONTAL_LAYOUT_MARGIN) * 2)
        let cellWidth = width / 3
        
        return CGSize(width: cellWidth, height: cellWidth * 1.75)
    }
    
    func showAlert() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Alert!!", message: "You must select at least one ambience", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Ok", style: .default) { (_) in
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (globalAmbiences.getAmbienceAt(index: indexPath.row).selected) {
            if globalAmbiences.getSelectedAmbiences().count <= 1 {
                  showAlert()
            } else {
                globalAmbiences.unselectAmbience(ambience: globalAmbiences.getAmbienceAt(index: indexPath.row))
            }
       } else {
           globalAmbiences.selectAmbience(ambience: globalAmbiences.getAmbienceAt(index: indexPath.row))
       }
       self.collectionView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
