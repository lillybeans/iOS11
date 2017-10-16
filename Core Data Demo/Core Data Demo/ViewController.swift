//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Lilly Tong on 2017-10-15.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate//refers to AppDelegate.swift
        let context = appDelegate.persistentContainer.viewContext //it's like your dbcontext
        
        /*
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newUser.setValue("ralphie", forKey:"username")
        newUser.setValue("myPass",forKey:"password")
        newUser.setValue(2,forKey:"age")
         */
        
        do {
            try context.save()
            print("Saved")
        } catch {
            
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Users")
        
        //Predicates is equivalent to your "WHERE" statements in SQL to filter the results
        
        //request.predicate = NSPredicate(format: "username = %@", "ralphie") //is there a user with username "ralphie"?
        //request.predicate = NSPredicate(format:"age < %@","10") //is there someone with age < 10?
        //request.predicate = NSPredicate(format: "username = %@", "lilly")
        
        request.returnsObjectsAsFaults = false //retrieve actual data
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let username = result.value(forKey: "username") as? String { //pretty confident cast will work
                        
                        context.delete(result)
                        
                        do {
                            try context.save()
                        } catch {
                            print("Delete failed")
                        }
                        
                        //Rename "ralphie" to "Dooley", this must be paired with the predicate
                        /*
                        result.setValue("Dooley",forKey:"username") //try to rename "ralphie" to "dooley"
                        do {
                            try context.save() //try writing to db
                        } catch {
                            //rename failed
                        }
                         */
                        
                        print(username)
                    }
                }
            } else {
                print("No Results")
            }
        } catch {
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

