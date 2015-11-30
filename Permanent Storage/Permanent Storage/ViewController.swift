//
//  ViewController.swift
//  Permanent Storage
//
//  Created by Tyler Swartz on 10/19/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the values
        NSUserDefaults.standardUserDefaults().setObject("Tyler Swartz", forKey: "name")
        
        // retrieve the values
        var userName = NSUserDefaults.standardUserDefaults().objectForKey("name") as! NSString
        
        
        // or store an array
        var arr = [1,2,3,4,5,6]
        
        NSUserDefaults.standardUserDefaults().setObject(arr, forKey: "userArray")
        
        // return the array, but it is saved without a type so need to specify it as an array
        var returnedArray = NSUserDefaults.standardUserDefaults().objectForKey("userArray") as! NSArray
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

