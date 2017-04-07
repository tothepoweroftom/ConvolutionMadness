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
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var blok = EffectBlokView(frame: CGRect(x: 20.0, y: Double(view.frame.height/2) - blockSize/2, width: blockSize, height: blockSize))
        blok.awakeFromNib()
        blok.setColor(colors[0])
        bloks.append(blok)
        
        view.addSubview(bloks[0])
        

        
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
