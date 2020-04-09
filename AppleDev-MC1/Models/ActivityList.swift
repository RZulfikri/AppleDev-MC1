//
//  ActivityList.swift
//  AppleDev-MC1
//
//  Created by Rahmat Zulfikri on 08/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import Foundation

class ActivityList {
    var arrActivities: [String] = []
    
    init(arrActivities: [String]?) {
        if let data = arrActivities {
            self.arrActivities = data
        }
    }
    
    func addActivity(activity: String) {
        arrActivities.append(activity)
    }
    
    func removeActivity(index: Int) {
        arrActivities.remove(at: index)
    }
    
    func getList() -> [String] {
        return arrActivities
    }
    
    func getCount() -> Int {
        return arrActivities.count
    }
}


let globalActivities = ActivityList.init(arrActivities: ["Working", "Hobby", "Study", "Sleaping", "Playing Games"])
