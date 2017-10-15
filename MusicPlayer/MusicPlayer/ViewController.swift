//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Lilly Tong on 2017-10-14.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    let audioPath = Bundle.main.path(forResource:"debussy-arabesque-1-breemer",ofType:"mp3")
    var timer = Timer() //for automatically advancing the scrubber

    @IBOutlet var volumeSlider: UISlider!
    @IBOutlet var scrubberSlider: UISlider!
    
    @IBAction func volumeChanged(_ sender: Any) {
        player.volume = volumeSlider.value
    }
    
    //when user drags the scrubber, we must seek track to where it is
    @IBAction func scrubberChanged(_ sender: Any) {
        player.currentTime = TimeInterval(scrubberSlider.value)
    }
    
    //automatically move scrubber along with song
    @objc func updateScrubber(){
        scrubberSlider.value = Float(player.currentTime)
    }
    
    @IBAction func play(_ sender: Any) {
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(ViewController.updateScrubber), userInfo:nil, repeats: true) //"self" means ViewController, since that's who we are updating regularly
    }
    
    
    @IBAction func pause(_ sender: Any) {
        player.pause()
        timer.invalidate() //pause scrubber movement
    }
    
    @IBAction func stop(_ sender: Any) {
        
        player.pause()
        timer.invalidate()
        
        //to restart
        player.currentTime = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            scrubberSlider.maximumValue = Float(player.duration) //set max value of scrubber to be length of track
        } catch {
            
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

