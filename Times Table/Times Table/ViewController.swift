//
//  ViewController.swift
//  Times Table
//
//  Created by Lilly Tong on 2017-10-01.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderChanged(_ sender: Any) {
       table.reloadData() //so table will refresh to reflect new slider value
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:"Cell")
        cell.textLabel?.text = String((Int(slider.value * 20)) * (indexPath.row+1));
        return cell;
        
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

