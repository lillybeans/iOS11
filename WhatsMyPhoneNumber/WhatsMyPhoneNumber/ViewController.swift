//
//  ViewController.swift
//  WhatsMyPhoneNumber
//
//  Created by Lilly Tong on 2017-10-01.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberField: UITextField!
    
    @IBAction func save(_ sender: Any) {
        UserDefaults.standard.set(numberField.text,forKey:"number")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let numberObject = UserDefaults.standard.object(forKey:"number")
        if let number = numberObject as? String{
            numberField.text = number
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

