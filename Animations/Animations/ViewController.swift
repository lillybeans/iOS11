//
//  ViewController.swift
//  Animations
//
//  Created by Lilly Tong on 2017-10-10.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var image: UIImageView!
    
    @IBOutlet var button: UIButton!
    
    var counter = 1
    var timer = Timer()
    var isAnimating = false
    
    @IBAction func fadeIn(_ sender: Any) {
        image.alpha = 0 //make image invisible
        UIView.animate(withDuration: 1, animations: {
                self.image.alpha = 1 //anytime you are inside a closure you need "self"
        })
    }
    
    
    @IBAction func slideIn(_ sender: Any) {
        image.center = CGPoint(x: image.center.x - 500, y: image.center.y)
        UIView.animate(withDuration: 2, animations: {
            self.image.center = CGPoint(x:self.image.center.x + 500, y: self.image.center.y) //need "self" everywhere since inside closure
            
        })
    }
    
    @IBAction func grow(_ sender: Any) {
        image.frame = CGRect(x:0, y:0, width:0, height: 0)
        UIView.animate(withDuration: 1, animations: {
            self.image.frame = CGRect(x:0,y:0,width:200,height:200)
        })
    }
    
    @objc func animate(){
        image.image=UIImage(named:"frame_\(counter)_delay-0.1s.gif")
        counter += 1
        if counter == 6 {
            counter = 0
        }
    }
    
    @IBAction func next(_ sender: Any) {
        
        if isAnimating{
            timer.invalidate()
            isAnimating = false //since we paused the animation
            button.setTitle("Start Animation", for: [])
        } else {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.animate), userInfo: nil, repeats: true)
            isAnimating = true
            button.setTitle("Stop Animation", for:[])
        }
        
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

