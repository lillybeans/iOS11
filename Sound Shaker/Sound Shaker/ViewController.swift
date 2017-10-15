//
//  ViewController.swift
//  Sound Shaker
//
//  Created by Lilly Tong on 2017-10-15.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //If user shook, play sound
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake {
            
            let subfolder = "sounds/"
            let soundArray = ["avalanche","cricket","dog","fox","frog"]
            let randomNumber = Int(arc4random_uniform(UInt32(soundArray.count))) //random number between 0 and soundArray.count-1. Do not forget to cast it back to integer
            
            let fileLocation = Bundle.main.path(forResource: subfolder + soundArray[randomNumber], ofType: ".mp3")
            
            do {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileLocation!))
                player.play()
            } catch {
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

