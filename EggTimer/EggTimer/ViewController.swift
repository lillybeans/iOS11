//
//  ViewController.swift
//  EggTimer
//
//  Created by Lilly Tong on 2017-09-29.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var time = 210
    
    @IBOutlet weak var timerLabel: UILabel!

    @objc func countdown(){
        if time > 0 {
            
            time -= 1
            timerLabel.text = String(time)
            
        } else {
            timer.invalidate()
        }
    }
    
    @IBAction func play(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countdown), userInfo: nil, repeats: true)
    }
    
    @IBAction func pause(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func minusTen(_ sender: Any) {
        if time >= 10 {
            time -= 10
            timerLabel.text = String(time) //update label
        }
    }
    
    @IBAction func plusTen(_ sender: Any) {
        time += 10
        timerLabel.text = String(time) //update label
    }
    
    
    @IBAction func reset(_ sender: Any) {
        time = 210
        timerLabel.text = String(time) //update label
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

