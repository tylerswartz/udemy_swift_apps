//
//  SecondViewController.swift
//  To Do List App
//
//  Created by Tyler Swartz on 10/21/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var inputAddItem: UITextField!
    
    
    @IBAction func addItemButton(sender: AnyObject) {
    
        toDoList.append(inputAddItem.text!)
        
        inputAddItem.text = ""
        
        NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "toDoList")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches:Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        inputAddItem.resignFirstResponder()
        
        return true
        
    }

}

