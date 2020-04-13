//
//  HistoryList.swift
//  AppleDev-MC1
//
//  Created by Rahmat Zulfikri on 12/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import Foundation

class HistoryList {
    var arrHistory: [History] = []
    
    init(arrHistory: [History]?) {
        if let data = arrHistory {
            self.arrHistory = data
        }
    }
    
    func addHistory(history: History) {
        self.arrHistory.append(history)
    }
    
    func getList() -> [History]{
        return self.arrHistory
    }
}

let globalHistory = HistoryList(arrHistory: [])
