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
    var booster: AKBooster!
    var pitchShifter: AKPitchShifter!

    var mixer: AKMixer!
    var gain: AKMixer!
    var convFile: URL!
    var inputNode: AKNode!
    var bypassToggle = false
    
    init(input: AKNode, convFile: URL) {
        self.inputNode = input
        self.convFile = convFile
        
        conv1 = AKConvolution(self.inputNode, impulseResponseFileURL: self.convFile, partitionLength: 256)
        booster = AKBooster(conv1, gain: 6.0)
        pitchShifter = AKPitchShifter(booster)
        pitchShifter.shift = -12.0
        mixer = AKMixer(pitchShifter)
    }
    
    func start(){
        conv1.start()
    }
    
    func stop() {
        conv1.stop()
    }
    
    func bypass(_ state: Bool) {
        
        if state {
            mixer.volume = 0.5
        } else {
            mixer.volume = 0.0

        }
        
    }
    
    
    
    
}
