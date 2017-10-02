//
//  ViewController.swift
//  Table Views
//
//  Created by Lilly Tong on 2017-10-01.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //let cellContent = ["Lilly","Minney","Jesson"]
    //let rows=50
    //var i=1
    
    //returns and sets number of rows in table (internal = private)
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 50
    }

    //for each cell in table, what should I put in there?
    //returns cell
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier: "Cell")
        //cell.textLabel?.text = cellContent[indexPath.row] //content of cell, possible textLabel is optional
        cell.textLabel?.text=String(indexPath.row+1)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

