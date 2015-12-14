//
//  RiderViewController.swift
//  ParseStarterProject
//
//  Created by Tyler Swartz on 12/13/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import MapKit

class RiderViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var callUberButton: UIButton!
    
    var locationManager = CLLocationManager()
    
    var lat:CLLocationDegrees = 0
    var lng:CLLocationDegrees = 0

    var riderRequestActive = false
    
    @IBAction func callUber(sender: AnyObject) {
    
        if riderRequestActive == false {
            
            var riderRequest = PFObject(className:"riderRequest")
            riderRequest["username"] = PFUser.currentUser()?.username
            riderRequest["location"] = PFGeoPoint(latitude: lat, longitude: lng)

            riderRequest.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    self.callUberButton.setTitle("Cancel Uberz", forState: UIControlState.Normal)
                    
                } else {
                    // There was a problem, check error.description
                    var alert = UIAlertController(title: "Could not call Uberz", message: "There was an error. Try again", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
            
            riderRequestActive = true
            
        } else {
            
            self.callUberButton.setTitle("Call Uberz", forState: UIControlState.Normal)
            
            riderRequestActive = false
            
            var query = PFQuery(className:"riderRequest")
            query.whereKey("username", equalTo:PFUser.currentUser()!.username!)
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
            
                if error == nil {
                    // The find succeeded.
                    // Do something with the found objects
                
                    if let objects = objects as? [PFObject] {
                
                        for object in objects {
                
                            object.deleteInBackground()
                        }
                    }
                } else {
                    // Log details of the failure
                    print(error)
                }
            
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Ask user location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var location:CLLocationCoordinate2D = manager.location!.coordinate
        
        lat = location.latitude
        lng = location.longitude
        
        print(location)
        
        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
        
        self.map.removeAnnotations(map.annotations)
        
        var pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        var objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = "Your Location"
        self.map.addAnnotation(objectAnnotation)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "logoutRider" {
            
            PFUser.logOut()
            
        }
        
    }
    

    
    
}
