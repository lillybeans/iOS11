//
//  MasterViewController.swift
//  Blog Reader
//
//  Created by Lilly Tong on 2017-10-15.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
       
        let url = URL(string: "https://www.googleapis.com/blogger/v3/blogs/10861780/posts?key=AIzaSyBkHoMc5PFPbptBXdSFiW-MDBFmffxQAN4")!
        
        //initiate HTTP request using our url
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("error in HTTP request")
            } else {
                if let urlContent = data {
                    //convert data to json
                    do {
                        
                        //1. delete all existing records in the db
                        let context = self.fetchedResultsController.managedObjectContext
                        let request = NSFetchRequest<Blog>(entityName:"Blog") //return type: Blog
                        
                        do {
                            let results = try context.fetch(request)
                            if results.count > 0 {
                                for result in results {
                                    context.delete(result)
                                }
                            }
                        } catch {
                            print("delete failed")
                        }

                        //2. store new records
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        //print(jsonResult)
                        
                        
                        if let items = jsonResult["items"] as? [[String:Any]] { //convert items into an array of dictionaries, where each record "item" is a dictionary with different (k,v) pairs
                            for item in items {
                                print(item["published"]!)
                                print(item["title"]!)
                                print(item["content"]!)
                                
                                let newEvent = Blog(context: context) //insert new object in "Blog" database
                                
                                // Save our data in coreData
                                newEvent.timestamp = Date()
                                newEvent.setValue(item["published"] as! String, forKey:"published")
                                newEvent.setValue(item["title"] as! String, forKey:"title")
                                newEvent.setValue(item["content"] as! String, forKey:"content")
                                
                                
                                // Save the context.
                                do {
                                    try context.save()
                                } catch {

                                    let nserror = error as NSError
                                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                                }
                                
                            }
                            
                            //we need async since task is not in main thread
                            DispatchQueue.main.async(execute: { //below code executed once above code has been completed
                                self.tableView.reloadData()
                            })
                        }
                    } catch {
                        
                    }
                }
                
            }
        }
        
        task.resume() //start task

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    @objc
    func insertNewObject(_ sender: Any) {
        let context = self.fetchedResultsController.managedObjectContext
        let newEvent = Blog(context: context)
             
        // If appropriate, configure the new managed object.
        newEvent.timestamp = Date()

        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
 */

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
            let object = fetchedResultsController.object(at: indexPath)
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    //fetchedResultsController is grabbing data from CoreData
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let Blog = fetchedResultsController.object(at: indexPath)
        configureCell(cell, withEvent: Blog)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false //we changed this to false, we don't want row to be editable
    }

    func configureCell(_ cell: UITableViewCell, withEvent Blog: Blog) {
        cell.textLabel!.text = Blog.title!.description
    }

    // MARK: - Fetched results controller (core data portion)

    var fetchedResultsController: NSFetchedResultsController<Blog> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Blog> = Blog.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // orders results
        let sortDescriptor = NSSortDescriptor(key: "published", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
             // Replace this implementation with code to handle the error appropriately.
             // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             let nserror = error as NSError
             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController<Blog>? = nil

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
            case .insert:
                tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
            case .delete:
                tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
            default:
                return
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .fade)
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .fade)
            case .update:
                configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! Blog)
            case .move:
                configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! Blog)
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         tableView.reloadData()
     }
     */

}

