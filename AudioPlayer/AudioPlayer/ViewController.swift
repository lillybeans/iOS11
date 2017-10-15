//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Lilly Tong on 2017-10-14.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit
import AVFoundation //Audio Visual Foundation, need this for audio

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    @IBOutlet var slider: UISlider! //volume slider
    
    @IBAction func play(_ sender: Any) {
        player.play()
    }
    @IBAction func pause(_ sender: Any) {
        player.pause()
    }

    @IBAction func sliderMoved(_ sender: Any) {
        player.volume = slider.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let audioPath = Bundle.main.path(forResource:"debussy-arabesque-1-breemer",ofType:"mp3")
        
        do { //just like "if let", but instead of checking if a variable exists, we are checking a whole command
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        } catch { //will execute if try failed
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

