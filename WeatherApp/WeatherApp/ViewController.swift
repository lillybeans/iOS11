//
//  ViewController.swift
//  WeatherApp
//
//  Created by Lilly Tong on 2017-10-01.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var cityTextField: UITextField!
    @IBAction func getWeather(_ sender: Any) {
        if let url = URL(string:"https://www.weather-forecast.com/locations/" + cityTextField.text!.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "-") + "/forecasts/latest"){
            let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with:request as URLRequest){
                data, response, error in
                var message = ""
                if let error = error{
                    print(error)
                } else {
                    if let unwrappedData = data{ //if html data not nil
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                        var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">" //cut off everything before summary
                        
                        if let contentArray = dataString?.components(separatedBy: stringSeparator){ //split using stringSeparator
                            
                            if contentArray.count > 1 { //will always have > 0, but not necessarily 1
                                stringSeparator = "</span>" //cut off everything after summary
                                let newContentArray = contentArray[1].components(separatedBy: stringSeparator) //we are only interest in the second element, which is after the split using String Separator
                                if newContentArray.count > 1 {
                                    
                                    message = newContentArray[0].replacingOccurrences(of: "&deg", with: "°") //degree: opt + shift + 8
                                    print(newContentArray[0])
                                }
                                
                                
                            }
                        }
                        
                        //print(dataString!)
                    }
                    
                }
                
                if message == "" {
                    message = "The weather couldn't be found. Please try again."
                }
                
                DispatchQueue.main.sync(execute:{
                    self.resultLabel.text = message //since resultLabel is in ViewController, but not within the closure "task", you need to tell the task it's from ViewController.
                })
            }
            
            task.resume()
        } else {
            resultLabel.text = "The weather couldn't be found. Please try again." //don't need "self" since outside task
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
   
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

