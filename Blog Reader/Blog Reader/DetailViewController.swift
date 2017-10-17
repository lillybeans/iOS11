//
//  DetailViewController.swift
//  Blog Reader
//
//  Created by Lilly Tong on 2017-10-15.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit
import WebKit

//details page will actually display the blogpost
class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet var webView: WKWebView! //container for displaying html
    
    func configureView() {
        // Update the user interface for the detail item.
        

        
        if let detail = detailItem {
            
            self.title = detail.value(forKey:"title") as! String //title of the article = title of view controller
            
            if let blogWebView = self.webView { //load into webview
                blogWebView.loadHTMLString(detail.value(forKey:"content") as! String, baseURL: nil) //load content as html
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Blog? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

