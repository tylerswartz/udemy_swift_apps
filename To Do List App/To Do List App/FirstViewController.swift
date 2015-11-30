//
//  FirstViewController.swift
//  To Do List App
//
//  Created by Tyler Swartz on 10/21/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit

var toDoList = [String]()

class FirstViewController: UIViewController, UITableViewDelegate {

    
    @IBOutlet weak var toDoTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Check permanent storage to see if list saved from previous app usage
        if NSUserDefaults.standardUserDefaults().objectForKey("toDoList") != nil {
            
            toDoList = NSUserDefaults.standardUserDefaults().objectForKey("toDoList") as! [String]
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoList.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = toDoList[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            toDoList.removeAtIndex(indexPath.row)
            
            NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "toDoList")
            
            toDoTable.reloadData()
            
        }
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        toDoTable.reloadData()
        
    }

}

