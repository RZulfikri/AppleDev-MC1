//
//  DurationModelPicker.swift
//  AppleDev-MC1
//
//  Created by Steven Tandianus on 09/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit

class DurationModelPicker: UIPickerView {
    
    var modelData: [DataModel]!
}

extension DurationModelPicker: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modelData.count
    }
}

extension DurationModelPicker: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.text = modelData[row].duration
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 42, weight: UIFont.Weight.thin)
        
        view.addSubview(label)
        
        view.transform = CGAffineTransform(rotationAngle: (90 * (.pi / 180)))
        
        return view
    }
}
