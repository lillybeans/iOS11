//
//  PlacesViewController.swift
//  Memorable Places
//
//  Created by Lilly Tong on 2017-10-14.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit

var places = [Dictionary<String,String>()] //each record is a dictionary with keys: name, lat, lon
var activePlace = -1 //need to pass this to the other view controller

class PlacesViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() { //not always called (i.e. won't be called if you press "Back" button)
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) { //called everytime we load the table
        
        //First check if there are already saved places in persistent storage
        if let savedPlaces = UserDefaults.standard.object(forKey:"places") as? [Dictionary<String,String>] {
            places = savedPlaces
        }
        
        if places.count == 1 && places[0].count == 0 { //if places is empty, append sample record
            places.remove(at:0)
            places.append(["name":"Taj Mahal","lat":"27.175277","lon":"78.042128"]) //sample
            
            //update permanent storage
            UserDefaults.standard.set(places,forKey:"places")
        }
        
        table.reloadData()
        activePlace = -1 //reset everytime we go back to the table
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count //the table has as many rows as there are items in "places"
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        if places[indexPath.row]["name"] != nil {
            cell.textLabel?.text = places[indexPath.row]["name"]
        }
        return cell
    }
    
    //switch to view "Map" whenever user clicks on a cell (place) in the table
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activePlace = indexPath.row //before seg, must update since we are passing activePlace
        performSegue(withIdentifier: "toMap", sender: nil)
    }

    
    //Part 1: editing of table row - enable
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Part 2: editing of table row - edit
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            places.remove(at:indexPath.row) //remove this place
            UserDefaults.standard.set(places,forKey:"places") //update permanent storage
            table.reloadData()
            
        }
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
