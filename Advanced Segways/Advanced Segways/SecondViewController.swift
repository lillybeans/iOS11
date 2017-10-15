//
//  SecondViewController.swift
//  Advanced Segways
//
//  Created by Lilly Tong on 2017-10-14.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var username = "Lilly" //will be updated by first controller using segway
    var activeRow = 0 //will be updated by first controller using segway

    override func viewDidLoad() {
        super.viewDidLoad()
        print(globalVariable)
        print(activeRow)
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
