//
//  SettingsAmbienceVC.swift
//  AppleDev-MC1
//
//  Created by Rahmat Zulfikri on 08/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit

class SettingsAmbienceVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let cellIdentifier = "ambienceCell"
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("collection view \(self.collectionView.frame) view \(self.view.frame)")
        print("collection view \(self.collectionView.bounds) view \(self.view.bounds)")
        self.collectionView.register(UINib(nibName: "AmbienceCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
 
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return globalAmbiences.getAmbienceList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AmbienceCell
        
        cell.image.image = UIImage(named: globalAmbiences.getAmbienceList()[indexPath.row].imageName)
        cell.image.frame = cell.bounds
          
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (view.frame.width-(12 * 2))/3
        
        return CGSize(width: width, height: width * 1.75)
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
