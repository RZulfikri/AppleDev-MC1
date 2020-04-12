//
//  SettingsActivityVC.swift
//  AppleDev-MC1
//
//  Created by Rahmat Zulfikri on 08/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit

class SettingsActivityVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let cellIdentifier = "activityCell"
    let sectionHeaderIdentifier = "sectionHeaderIdentifier"
    
    let HORIZONTAL_LAYOUT_MARGIN: Float = 20

    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonAdd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "ActivityCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.layoutMargins.left = CGFloat(HORIZONTAL_LAYOUT_MARGIN)
        self.tableView.layoutMargins.right = CGFloat(HORIZONTAL_LAYOUT_MARGIN)
        self.tableView.tableFooterView = UIView(frame: .zero
        )
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
   }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalActivities.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ActivityCell
        cell.title.text = globalActivities.getList()[indexPath.row]
       return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        nil
    }
    
    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "New Activity", message: "Insert your new activity name", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            if let activityName = alertController.textFields?[0].text {
                globalActivities.addActivity(activity: activityName)
                self.tableView.reloadData()
            }
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Activity Name"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onTouchButtonAdd(_ sender: UIButton) {
        showInputDialog()
    }
    
}
