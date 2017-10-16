//
//  ViewController.swift
//  APIDemo
//
//  Created by Lilly Tong on 2017-10-15.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func submit(_ sender: Any) {
        
        if let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?q="+cityTextField.text!.replacingOccurrences(of: " ", with: "%20")+"&appid=faf759f689bbb025c329021cfc2f1a49") { //use "if let" to check if city text field's entry is valid, also replace strings with "%20"
            
            //this is the other way to send a HTTP request directly by bypassing the URLRequest
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let urlContent = data { //if we have some data, should be json
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject //need casting Any -> AnyObject
                            
                            //print(jsonResult)
                            
                            //what this mess is:
                            //we try to cast jsonResult["weather"] to a NSArray
                            //we try to cast jsonResult["weather"][0] to a NSDictionary
                            //we try to cast jsonResult["weather"][0]["description"] to a String
                            
                            if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String{
                                
                                //non-blocking update UI to start a separate thread so we don't wait
                                DispatchQueue.main.sync(execute:{
                                    self.resultLabel.text = description
                                })
                            }
                            
                            
                        } catch {
                            print("JSON processing failed")
                        }
                        
                    }
                }
            }
            
            task.resume()
        } else {
            resultLabel.text = "Couldn't find weather for that city - please try again"
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

