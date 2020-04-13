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
            arrAmbience.insert(newAmbience, at: index)
        }
    }
    
    func unselectAmbience(ambience: Ambience) {
        if let index = arrAmbience.firstIndex(where: { data in
           return data.id == ambience.id
       }) {
           arrAmbience.remove(at: index)
           var newAmbience = ambience
           newAmbience.selected = false
           arrAmbience.insert(newAmbience, at: index)
       }
    }
    
    func getAmbienceList() -> [Ambience] {
        return self.arrAmbience
    }
    
    func getAmbienceAt(index: Int) -> Ambience {
        return self.arrAmbience[index]
    }
    
    func getSelectedAmbiences() -> [Ambience] {
        return self.arrAmbience.filter({ ambience in
            return ambience.selected
        })
    }
    
    func getSelectedAmbienceIndexAt(index: Int) -> Ambience {
        return getSelectedAmbiences()[index]
    }
}

let globalAmbiences = AmbienceList(arrAmbience: [
    Ambience(id: 1, imageName: "Fire", audioName: "Campfire"),
    Ambience(id: 2, imageName: "Cafe", audioName: "Cafe"),
    Ambience(id: 3, imageName: "Forest", audioName: "Forest"),
    Ambience(id: 4, imageName: "Cyberpunk", audioName: "Cyberpunk"),
    Ambience(id: 5, imageName: "Bird", audioName: "Bird"),
])
