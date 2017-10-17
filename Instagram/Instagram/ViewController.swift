//
//  ViewController.swift
//  Instagram
//
//  Created by Lilly Tong on 2017-10-16.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit
import Parse //needed, allows you to write to AWS

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //1. insert item
        /*
        let comment = PFObject(className:"Comment") //create new parse object, under the table "Comment"
        comment["text"] = "Nice shot!"
        comment.saveInBackground { (success, error) in //returns 2 things: success and error
            if(success){
                print("Save successful")
            }else{
                print("Save failed")
            }
        }
         */
        
        //2. get item
        let query = PFQuery(className:"Comment")
        query.getObjectInBackground(withId: "EJPbHY6Rym") { (object, error) in 
            if let comment = object { //retrieve item, and if it exists, set it to "comment"
                
                //3.update item
                comment["text"] = "Awful shot!"
                comment.saveInBackground(block: { (success, error) in
                    if(success){
                        print("Update successful")
                    }else{
                        print("Update failed")
                    }
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

