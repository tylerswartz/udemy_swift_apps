//
//  RequestViewController.swift
//  ParseStarterProject
//
//  Created by Tyler Swartz on 12/17/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import MapKit
import Parse

class RequestViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var requestLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var requestUsername:String = ""
    
    @IBAction func pickupRider(sender: AnyObject) {
        
        var query = PFQuery(className:"riderRequest")
        query.whereKey("username", equalTo:requestUsername)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                // Do something with the found objects
                
                if let objects = objects as? [PFObject] {
                    
                    for object in objects {
                        
                        var query = PFQuery(className:"riderRequest")
                        query.getObjectInBackgroundWithId(object.objectId!) {
                            (objects: PFObject?, error: NSError?) -> Void in
                            if error != nil {
                                print(error)
                            } else if let object = object {
                                
                                object["driverResponded"] = PFUser.currentUser()!.username!
                                object.saveInBackground()
                                
                            }
                    
                        }
                    }
                }
                    
            } else {
                // Log details of the failure
                print(error)
            }
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        print(requestUsername)
        print(requestLocation)
        
        
        let center = requestLocation
        let region = MKCoordinateRegion(center: requestLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.map.setRegion(region, animated: true)
        var objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = requestLocation
        objectAnnotation.title = requestUsername
        self.map.addAnnotation(objectAnnotation)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
