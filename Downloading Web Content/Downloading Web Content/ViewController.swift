//
//  ViewController.swift
//  Downloading Web Content
//
//  Created by Lilly Tong on 2017-10-01.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() { //step 1: load view
        
        webView = WKWebView()

        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        view = webView //this is view controller's view, we are setting its view portal to be webView
        
    }
    
    override func viewDidLoad() { //step 2: after view loaded, load content “stackoverflow.com" into view
        super.viewDidLoad()
        
        if let url = URL(string: "https://www.stackoverflow.com"){
            let request = NSMutableURLRequest(url:url)
            
            //the following task will retrieve the HTML of the given url
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in //task return 3 variables: data, response, error. "in" means we will use these 3 vars below
                if let error = error{ //if error is not nil, we have a problem
                    print(error)
                }else{ //no problem
                    if let unwrappedData = data{
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        print(dataString)
                        
                        DispatchQueue.main.sync(execute:{ //multithread/multicore for fast rendering
                            
                            //update UI
                            
                        })
                    }
                }
            }
            
            task.resume() //even it's called "resume", we are running task for the first time
        }
        
        /*
        let url = URL(string:"https://www.stackoverflow.com")
        webView.load(URLRequest(url: url))
         */

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

