//
//  ViewController.swift
//  SwipesAndShakes
//
//  Created by Lilly Tong on 2017-10-15.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //right swipe: add gesture recognizer
        let swipeRight = UISwipeGestureRecognizer(target:self, action:#selector(ViewController.swiped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right //detect right swipe
        view.addGestureRecognizer(swipeRight) //in the case of a map, we added this to our map. You add it to wherever you want the gesture to be detected
        
        //left swipe: add gesture recognizer
        let swipeLeft = UISwipeGestureRecognizer(target:self, action:#selector(ViewController.swiped(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left //detect right swipe
        view.addGestureRecognizer(swipeLeft) //in the case of a map, we added this to our map. You add it to wherever you want the gesture to be detected
        
    }
    
    //Shaking
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype ==  UIEventSubtype.motionShake {
            print("Device was shaken")
        }
    }
    
    @objc func swiped(gesture:UISwipeGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer { //attempt to cast
            switch swipeGesture.direction {
                case UISwipeGestureRecognizerDirection.right:
                    print("User swiped right")
                case UISwipeGestureRecognizerDirection.left:
                    print("User swiped left")
                default:
                    break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

