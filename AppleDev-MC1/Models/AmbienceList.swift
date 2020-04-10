//
//  AmbienceList.swift
//  AppleDev-MC1
//
//  Created by Rahmat Zulfikri on 10/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import Foundation

class AmbienceList {
    private var arrAmbience: [Ambience] = []
    
    init(arrAmbience: [Ambience]?) {
        if let data = arrAmbience {
            self.arrAmbience = data
        }
    }
    
    func selectAmbience(ambience: Ambience) {
        if let index = arrAmbience.firstIndex(where: { data in
            return data.id == ambience.id
        }) {
            arrAmbience.remove(at: index)
            var newAmbience = ambience
            newAmbience.selected = true
            arrAmbience.insert(ambience, at: index)
        }
    }
    
    func unselectAmbience(ambience: Ambience) {
        if let index = arrAmbience.firstIndex(where: { data in
           return data.id == ambience.id
       }) {
           arrAmbience.remove(at: index)
           var newAmbience = ambience
           newAmbience.selected = false
           arrAmbience.insert(ambience, at: index)
       }
    }
    
    func getAmbienceList() -> [Ambience] {
        return self.arrAmbience
    }
}

let globalAmbiences = AmbienceList(arrAmbience: [
    Ambience(id: 1, imageName: "ambience-1"),
    Ambience(id: 2, imageName: "ambience-2"),
    Ambience(id: 3, imageName: "ambience-3"),
    Ambience(id: 4, imageName: "ambience-4"),
    Ambience(id: 5, imageName: "ambience-5"),
    Ambience(id: 6, imageName: "ambience-6"),
    Ambience(id: 7, imageName: "ambience-7"),
    Ambience(id: 8, imageName: "ambience-8"),
    Ambience(id: 9, imageName: "ambience-9"),
])
