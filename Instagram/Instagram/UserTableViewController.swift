
//
//  UserTableViewController.swift
//  Instagram
//
//  Created by Lilly Tong on 2017-10-24.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit
import Parse //need for user logout

class UserTableViewController: UITableViewController {

    var usernames: [String] = [] //must specify type when initializing
    var objectIds: [String] = [] //user object IDs
    var isFollowing = ["":false] //dict[string=objectId:bool], initialize to specify content type, but we will need to removeAll (clear) this later
    
    @IBAction func logoutUser(_ sender: Any) {
        PFUser.logOut()
        performSegue(withIdentifier: "logoutSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get list of users from AWS using Parse, refresh user table content
        let query = PFUser.query() //don't need PFObject(classname:"User") because this is a default class created by Parse
        
        //Filter results using WHERE clause: get friends (not current user)
        query?.whereKey("username", notEqualTo: PFUser.current()?.username)
        
        query?.findObjectsInBackground(block: { (users, error) in
            if error != nil {
                print(error!)
            } else if let users = users { //all users that's not me (The logged in user)
                for object in users {
                    
                    self.isFollowing.removeAll() //clear our array
                    
                    if let user = object as? PFUser{
                        if let username = user.username{
                            if let objectId = user.objectId{
                                let usernameArray = username.components(separatedBy: "@") //get the "x" in x@abc.com
                                self.usernames.append(usernameArray[0]) //add to our array of usernames
                                self.objectIds.append(objectId)
                                
                                let query = PFQuery(className:"Following")
                                
                                //for each user != logged_in_user that we are looping through, check if the logged_in_user is following this user
                                query.whereKey("follower", equalTo: PFUser.current()?.objectId) //follower: logged in user
                                query.whereKey("following", equalTo: objectId) //following: current user in loop
                            
                                
                                //try and see if there is a result matching the above two query conditions
                                query.findObjectsInBackground(block: { (objects, error) in
                                    if let objects = objects {
                                        if objects.count > 0 { //should only be 1 record
                                            self.isFollowing[objectId] = true
                                            print("isFollowing[\(objectId)] is set to true")
                                        } else {
                                            self.isFollowing[objectId] = false
                                        }
                                    }
                                    
                                    self.tableView.reloadData()
                                })
                            }
                        }
                    }
                }
                
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //Called whenever a row in the table is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if let followsBoolean = isFollowing[objectIds[indexPath.row]]{
            if followsBoolean { //if currently following, tapping should unfollow
                
                isFollowing[objectIds[indexPath.row]] = false //unfollow
                
                cell?.accessoryType = UITableViewCellAccessoryType.none
                
                let query = PFQuery(className:"Following")
                
                //for each user != logged_in_user that we are looping through, check if the logged_in_user is following this user
                query.whereKey("follower", equalTo: PFUser.current()?.objectId) //follower: logged in user
                query.whereKey("following", equalTo: objectIds[indexPath.row]) //following: current user in loop
                
                
                //try and see if there is a result matching the above two query conditions
                query.findObjectsInBackground(block: { (objects, error) in
                    if let objects = objects {
                        for object in objects {
                            object.deleteInBackground() //unfollow
                        }
                    }
                    
                    self.tableView.reloadData()
                })
                
                
            } else { //follow
                
                isFollowing[objectIds[indexPath.row]] = true //follow
                
                cell?.accessoryType = UITableViewCellAccessoryType.checkmark //now following the user
                
                let following = PFObject(className: "Following")
                following["follower"] = PFUser.current()?.objectId
                following["following"] = objectIds[indexPath.row] //the array objectIds stores this user id at index indexPath.row
                following.saveInBackground()
            }
        }

        
        

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel!.text = usernames[indexPath.row]

        if let followsBoolean = isFollowing[objectIds[indexPath.row]]{ //since optional, we must wrap
            if followsBoolean { //if logged in user follows user in current row in the table
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

