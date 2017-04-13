//
//  ConvBlok.swift
//  ConvolutionMadness
//
//  Created by Tom Power on 10/04/2017.
//  Copyright © 2017 MOBGEN:Lab. All rights reserved.
//

import Foundation
import AudioKit

class ConvBlok {
    var conv1: AKConvolution!
    var conv2: AKConvolution!
    var mixer: AKDryWetMixer!
    var gain: AKMixer!
    var convFile: URL!
    var inputNode: AKNode!
    var bypassToggle = false
    
    init(input: AKNode, convFile: URL) {
        self.inputNode = input
        self.convFile = convFile
        
        conv1 = AKConvolution(self.inputNode, impulseResponseFileURL: self.convFile)
        gain = AKMixer(conv1)
        gain.volume = 0.01
        conv2 = AKConvolution(gain, impulseResponseFileURL: convFile)
        mixer = AKDryWetMixer(inputNode, conv1, balance: 0.5)
    }
    
    func start(){
        conv1.start()
        conv2.start()
    }
    
    func stop() {
        conv1.stop()
        conv2.stop()
    }
    
    func bypass(_ state: Bool) {
        
        if state {
            mixer.balance = 0.5
        } else {
            mixer.balance = 0.0

        }
        
    }
    
    
    
    
}
