//
//  FirstViewController.swift
//  ToDoList
//
//  Created by Lilly Tong on 2017-10-01.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit

//for viewing and displaying list of items on ToDo list
class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var items:[String]=[] //temp var, will be populated in viewDidLoad()
    
    //display as many rows as there are items in to-do list
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    //CELL: display an item in "items"
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    //DELETE: for deleting a row from table
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            items.remove(at:indexPath.row)
            table.reloadData()
            UserDefaults.standard.set(items, forKey: "items") //update system's "items" with our temp var items
        }
    }
    
    //called when switching tabs
    //refresh data everytime we go back to Todo List
    override func viewDidAppear(_ animated: Bool) {
        
        //first try retrieve any existing list of items recorded in system
        let itemsObject = UserDefaults.standard.object(forKey:"items")
        
        if let tempItems = itemsObject as? [String]{ //array exists
            items = tempItems //load system records into "items"
        }
        
        
        table.reloadData()
    }
    
    //not called when switching tabs
    override func viewDidLoad() {

        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

