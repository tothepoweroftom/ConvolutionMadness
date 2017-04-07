//
//  ViewController.swift
//  ConvolutionMadness
//
//  Created by Tom Power on 05/04/2017.
//  Copyright © 2017 MOBGEN:Lab. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    var bloks = [EffectBlokView]()
    
    var blockSize = 200.0
    
    var colors = [UIColor(rgb: 0xF62D48), UIColor(rgb: 0xFBCE09), UIColor(rgb: 0xAAE5BB)]
    var margin = 20.0
    
    
    var convArray = [AKConvolution]()
    var volMixerArray = [AKMixer]()
    var conv: AKConvolution!

    var mixerArray = [AKDryWetMixer]()
    var vol : AKMixer!
    var urls = [URL]()
    var input: AKMicrophone!
    var booster: AKBooster!
    var audio: AKAudioPlayer!
    
    var mixloop: AKAudioFile!
        

    
    
    @IBOutlet weak var volSlider: UISlider!


    override func viewDidLoad() {
        super.viewDidLoad()
        margin = (Double(view.frame.width) - blockSize*3)/4
        // Do any additional setup after loading the view, typically from a nib.
        for i in 0...2 {
            var blok = EffectBlokView(frame: CGRect(x: margin + i*(blockSize + margin), y: Double(view.frame.height/2) - blockSize/2, width: blockSize, height: blockSize))
            blok.setSliderWidth(blockSize - 20.0)

            blok.awakeFromNib()
            blok.setColor(colors[i])
            bloks.append(blok)
        
            view.addSubview(bloks[i])
        

        }
        for i in 0...2 {
            let urlpath = Bundle.main.path(forResource: "\(i+1)", ofType: ".wav")
            let fileURL = URL(fileURLWithPath: urlpath!)
            urls.append(fileURL)
        }
        do {
            
            let urlpath = Bundle.main.path(forResource: "mixloop", ofType: ".wav")
            let fileURL = URL(fileURLWithPath: urlpath!)


           mixloop = try AKAudioFile(forReading: fileURL)
           audio =  try AKAudioPlayer(file: mixloop, looping: true, completionHandler: nil)
        } catch {
            
        }
        print(urls)
        AKSettings.audioInputEnabled = true
        do {
//         try AKSettings.session.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
         try AKSettings.setSession(category: .playAndRecord, with: .defaultToSpeaker)
        } catch {
            
        }
//        input = AKMicrophone()
        conv = AKConvolution(audio, impulseResponseFileURL: urls[0], partitionLength: 1024)
        var vol1 = AKDryWetMixer(audio, conv)
        var conv2 = AKConvolution(vol1, impulseResponseFileURL: urls[1], partitionLength: 1024)
        var vol2 = AKMixer(conv2)
        vol2.volume = 0.01

        var conv3 = AKConvolution(vol2, impulseResponseFileURL: urls[2], partitionLength: 1024)
        
        convArray.append(conv)
        convArray.append(conv2)
        convArray.append(conv3)

        

        
        vol = AKMixer(conv3)
        
        vol.volume = 1.0
        
        

        
  
        
 

        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AudioKit.output = vol
        AudioKit.start()
        for conv in convArray {
            conv.start()
        }
        audio.play()

        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupAudio() {

        

    }
    
    
    @IBAction func volSliderChanged(_ sender: UISlider) {
        vol.volume = Double(sender.value)
    }


}




extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
