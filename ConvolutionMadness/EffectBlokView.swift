//
//  EffectBlokView.swift
//  ConvolutionMadness
//
//  Created by Tom Power on 07/04/2017.
//  Copyright © 2017 MOBGEN:Lab. All rights reserved.
//

import UIKit

class EffectBlokView: UIView {
    var changeButton: UIButton!
    var slider: UISlider!
    var switchOn: UISwitch!
    
    var btWidth = 60.0
    var btHeight = 20.0
    
    var slWidth = 100.0
    var slHeight = 10.0
    
    var swWidth = 20.0
    var swHeight = 10.0

  

    
    override func awakeFromNib() {
        changeButton = UIButton(frame: CGRect(x: Double(self.frame.width/2) - btWidth/2, y: Double(self.frame.height) - btHeight, width: btWidth, height: btHeight))
        changeButton.setTitle("Change", for: .normal)
        changeButton.tintColor = .white
        
       slider = UISlider(frame: CGRect(x: frame.width/2 - CGFloat(slWidth/2), y: frame.height/2 - CGFloat(slHeight/2), width: CGFloat(slWidth), height: CGFloat(slHeight)))
       slider.maximumTrackTintColor = self.backgroundColor
       slider.minimumTrackTintColor = .white
        
        switchOn = UISwitch(frame: CGRect(x: Double(frame.width/2) - swWidth/2, y: 5.0 + swHeight, width: swWidth, height: swHeight))
        switchOn.onTintColor = self.backgroundColor
        
        self.addSubview(changeButton)
        self.addSubview(slider)
        self.addSubview(switchOn)
        
    }

    func setColor(_ col: UIColor) {
        backgroundColor = col
    }
}
