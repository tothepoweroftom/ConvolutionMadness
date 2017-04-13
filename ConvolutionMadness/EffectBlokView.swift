//
//  EffectBlokView.swift
//  ConvolutionMadness
//
//  Created by Tom Power on 07/04/2017.
//  Copyright © 2017 MOBGEN:Lab. All rights reserved.
//

import UIKit
import PaperSwitch

protocol EffectBlokDelegate {
    func sliderDidUpdate(_ sender: EffectBlokView)
    func slider2DidUpdate(_ sender: EffectBlokView)

    func bypass(_ sender: EffectBlokView)
}

class EffectBlokView: UIView {
    var changeButton: UIButton!
    var slider: UISlider!
    var slider2: UISlider!

    var switchOn: UISwitch!
    
    var btWidth = 100.0
    var btHeight = 20.0
    
    var slWidth = 100.0
    var slHeight = 10.0
    
    var swWidth = 20.0
    var swHeight = 10.0
    
    var id: Int!
    
    var delegate: EffectBlokDelegate!
    var isBypassed = false

  

    
    override func awakeFromNib() {
        changeButton = UIButton(frame: CGRect(x: Double(self.frame.width/2) - btWidth/2, y: Double(self.frame.height) - btHeight - 10.0, width: btWidth, height: btHeight))
        changeButton.setTitle("Change", for: .normal)
        changeButton.tintColor = .white
        
        
       slider = UISlider(frame: CGRect(x: frame.width/2 - CGFloat(slWidth/2), y: frame.height/2 - CGFloat(slHeight/2), width: CGFloat(slWidth), height: CGFloat(slHeight)))
       slider.maximumTrackTintColor = self.backgroundColor
       slider.backgroundColor = self.backgroundColor
       slider.minimumTrackTintColor = .white
        slider.addTarget(self, action: #selector(updateSliderValue), for: .touchDragInside)
        
        slider2 = UISlider(frame: CGRect(x: frame.width/2 - CGFloat(slWidth/2), y: frame.height/2 + CGFloat(slHeight*4), width: CGFloat(slWidth), height: CGFloat(slHeight)))
        slider2.maximumTrackTintColor = self.backgroundColor
        slider2.backgroundColor = self.backgroundColor
        slider2.minimumTrackTintColor = .white
        slider2.minimumValue = -24.0
        slider2.isContinuous = false
        slider2.maximumValue = 24.0
        slider2.addTarget(self, action: #selector(updateSliderValue2), for: .touchDragInside)
        
        switchOn = UISwitch(frame: CGRect(x: Double(frame.width/2) - swWidth, y: 5.0 + swHeight, width: swWidth, height: swHeight))
        switchOn.onTintColor = self.backgroundColor
        switchOn.backgroundColor = self.backgroundColor
        
//        self.addSubview(changeButton)
        self.addSubview(slider)
        self.addSubview(slider2)

        self.addSubview(switchOn)
        
    }

    func setColor(_ col: UIColor) {
        backgroundColor = col
    }
    
    func setID(_ id: Int) {
        
        self.id = id
        
    }
    
    func setSliderWidth(_ w: Double) {
        slWidth = w
    }
    
    func updateSliderValue(){
        delegate.sliderDidUpdate(self)
    }
    func updateSliderValue2(){
        delegate.slider2DidUpdate(self)
    }
    
    func bypassToggle() {
        isBypassed != isBypassed
    }
}
