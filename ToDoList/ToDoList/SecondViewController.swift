//
//  SecondViewController.swift
//  ToDoList
//
//  Created by Lilly Tong on 2017-10-01.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var itemTextField: UITextField!
    
    //keeps track and adds new items to our system to-do list
    @IBAction func add(_ sender: Any) {
        
        let itemsObject = UserDefaults.standard.object(forKey: "items")
        
        var items:[String]
        
        if let tempItems = itemsObject as? [String] {
            
            items = tempItems
            
            items.append(itemTextField.text!)
            
            print(items)
            
        } else {
            
            items = [itemTextField.text!]
            
        }
        
        UserDefaults.standard.set(items, forKey: "items")
        
        itemTextField.text = ""
    }
    
    //user clicks anywhere on main screen: keyboard should disappear
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //UITextFieldDelegate function
    // user clicks "return" on keyboard: keyboard should disappear
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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

