//
//  ViewController.swift
//  Permanent Data Storage
//
//  Created by Lilly Tong on 2017-10-01.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //UserDefaults.standard.set("Lilly",forKey:"name")
        let nameObject = UserDefaults.standard.object(forKey:"name") //object not necessarily string
        if let name = nameObject as? String{ //if we are able to cast nameObject to string, then "name" will be set
            print(name)
        }
        
        let arr = [1,2,3,4]
        
        //UserDefaults.standard.set(arr, forKey:"array") //save array
        let arrayObject = UserDefaults.standard.object(forKey:"array")
        if let array = arrayObject as? NSArray{
            print(array)
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

