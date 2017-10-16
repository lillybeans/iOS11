//
//  ViewController.swift
//  Login Demo
//
//  Created by Lilly Tong on 2017-10-15.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet var logOutButton: UIButton!
    
    var isLoggedIn = false
    
    @IBAction func logout(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users") //return type: NSFetchRequestResult
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] { //must cast results to be able to manage (delete from context)
                    context.delete(result)
                    
                    do {
                        try context.save()
                    } catch {
                        print ("deleting the user failed")
                        
                    }
                }
                
                label.alpha = 0 //hide
                logOutButton.alpha = 0 //hide
                //textField.alpha = 1 //appear
                logInButton.setTitle("Login",for:[])
                logInButton.alpha = 1 //appear
                
                
                isLoggedIn = false //update logged in status
            }
            
        } catch {
            
        }
    }
    
    
    @IBAction func login(_ sender: Any) { //this function is used for either updating name or logging in
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        if isLoggedIn { //then update username
            let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Users")
            
            do { //Try: fetch results from db
                let results = try context.fetch(request)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] { //cast
                        result.setValue(textField.text, forKey:"name") //update name
                        
                        do { //Try: save new name
                            try context.save()
                        } catch {
                            print ("update username save failed")
                        }
                    }
                    label.text = "Hi there " + textField.text! + "!"
                }
            } catch {
                print("update username failed")
            }
            
        } else { //create new user in database
            let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context) //create new record in "Users"
            newValue.setValue(textField.text, forKey:"name") //for the new record, set its "name" attribute to whatever's in the textfield
            
            do {
                try context.save()
                //textField.alpha = 0 //hide
                //logInButton.alpha = 0 //hide
                logInButton.setTitle("Update username",for:[])
                label.alpha = 1 //show
                label.text = "Hi there " + textField.text! + "!"
                logOutButton.alpha = 1 // show
                
                isLoggedIn = true //update loggedIn status
                
            } catch {
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CoreData
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Users") //retrieve from database
        
        //Looking up data in databases
        //request.predicate = NSPredicate(format: "name = %@", "Lilly") //look for name = something, that something is Lilly
        
        request.returnsObjectsAsFaults = false //so we retrieve actual data instead of schema
        do {
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject]{ //go through records in "Users"
                
                if let username = result.value(forKey:"name") as? String {
                    //textField.alpha = 0 //hide
                    //logInButton.alpha = 0 //hide
                    logInButton.setTitle("Update username", for:[]) //[] means for default state of the button
                    label.alpha = 1 //show
                    label.text = "Hi there " + username + "!"
                    logOutButton.alpha = 1
                }
                
            }
        } catch {
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

