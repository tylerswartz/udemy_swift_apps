//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Tyler Swartz on 11/29/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //access core data
        
        // delegate is first part
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // handler to be able to access the database
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
    /*
        //add user to database
        
        //specify which entity we want to add
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        
        //set values of attributes for that new user
        newUser.setValue("Jody", forKey: "username")
        newUser.setValue("paadss123", forKey: "password")
        
        // save to DB
        do {
            
            try context.save()
            
        } catch {
            
            print("there was a problem")
            
        } 
    */
        
        
        //retrieve data from DB
        let request = NSFetchRequest(entityName: "Users")
        
    /*
        // search DB for specific item
        request.predicate = NSPredicate(format: "username = %@", "Jody")
    */
        
        //allows you to access values of data. If set to true then you get summary of what was returned.
        request.returnsObjectsAsFaults = false
        
        //var to store the data back from DM
        do {
            
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    //convert to string
                    if let username = result.valueForKey("username") as? String {
                    
                        print(username)

                    }
                    
                   /*

                    //to modify value
                    result.setValue("NewName", forKey: "username")
                    do {
                        try context.save()
                    } catch {
                        print("error saving")
                    }
                    
                    //delete object
                    context.deleteObject(result)
                    do {
                        try context.save()
                    } catch {
                        print("error saving")
                    }
                    
                    
                    */
                    
                    
                    
                }
                
            }
            
        } catch {
            
            print("there was an error, fetch failed")
        
        }

        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

