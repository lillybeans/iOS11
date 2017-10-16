//
//  ViewController.swift
//  Downloading Images From the Web
//
//  Created by Lilly Tong on 2017-10-15.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var bachImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if image already saved locally, pull it up
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) //this is where we can save user documents
        
        if documentsPath.count > 0 {
            let documentsDirectory = documentsPath[0]
            let restorePath = documentsDirectory + "/bach.jpg"
            bachImageView.image = UIImage(contentsOfFile: restorePath) //load local image into our image
        }
        
        
        //otherwise, download and store the image locally

        /*
        let url = URL(string:"https://upload.wikimedia.org/wikipedia/commons/6/6a/Johann_Sebastian_Bach.jpg")!
        let request = NSMutableURLRequest(url:url)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data,response,error in //return 3 things
            
            if error != nil {
                print(error!)
            } else {
                if let data = data {
                    if let bachImage = UIImage(data: data) { //if we can convert
                        self.bachImageView.image = bachImage //inside closure, need "self"
                        
                        //save image locally on device
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) //this is where we can save user documents
                        
                        if documentsPath.count > 0 {
                            let documentsDirectory = documentsPath[0]
                            let savePath = documentsDirectory + "/bach.jpg"
                            do {
                                try UIImageJPEGRepresentation(bachImage, 1)?.write(to: URL(fileURLWithPath: savePath)) // "1" is compression quality
                            } catch {
                                
                            }
                            
                        }
                    }
                }
            }
            
        }
        task.resume() //even if it's first time executing
         */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

