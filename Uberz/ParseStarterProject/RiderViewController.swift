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
    var driverEnroute = false
    
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
        
        //check if ride request has been accepted
        var query = PFQuery(className:"riderRequest")
        query.whereKey("username", equalTo:PFUser.currentUser()!.username!)
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                // Do something with the found objects
                
                if let objects = objects as? [PFObject] {
                    
                    for object in objects {
                        
                        if let driverUsername = object["driverResponded"] {
                            
                            //query to get location of driver
                            var query = PFQuery(className:"driverLocation")
                            query.whereKey("username", equalTo:driverUsername)
                            
                            query.findObjectsInBackgroundWithBlock {
                                (objects: [AnyObject]?, error: NSError?) -> Void in
                                
                                if error == nil {
                                    // The find succeeded.
                                    // Do something with the found objects
                                    
                                    if let objects = objects as? [PFObject] {
                                        
                                        for object in objects {
                                            
                                            if let driverLocation = object["driverLocation"] as? PFGeoPoint {
                                                
                                                let driverCLLocation = CLLocation(latitude: driverLocation.latitude, longitude: driverLocation.longitude)
                                                
                                                let userCLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
                                                
                                                let distanceMeters = userCLLocation.distanceFromLocation(driverCLLocation)
                                                let distanceKM = distanceMeters / 1000
                                                let roundedDistance = Double(round(distanceKM * 10) / 10)
                                                
                                                self.callUberButton.setTitle("Driver enroute -\(roundedDistance)km away", forState: UIControlState.Normal)
                                                
                                                self.driverEnroute = true
                                                
                                                let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                                                
                                                //figure out driver lat change to scale the map properly to fit both pins. Abs takes the postive value. Double it to get scale across map and a bit of extra space so driver isn't on edge of map.
                                                let latDelta = abs(driverLocation.latitude - location.latitude) * 2 + 0.005
                                                let lngDelta = abs(driverLocation.longitude - location.longitude) * 2 + 0.005
                                                
                                                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lngDelta))
                                                
                                                self.map.setRegion(region, animated: true)
                                                
                                                self.map.removeAnnotations(self.map.annotations)
                                                
                                                var pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude, location.longitude)
                                                var objectAnnotation = MKPointAnnotation()
                                                objectAnnotation.coordinate = pinLocation
                                                objectAnnotation.title = "Your Location"
                                                self.map.addAnnotation(objectAnnotation)
                                                
                                                pinLocation = CLLocationCoordinate2DMake(driverLocation.latitude, driverLocation.longitude)
                                                objectAnnotation = MKPointAnnotation()
                                                objectAnnotation.coordinate = pinLocation
                                                objectAnnotation.title = "Driver Location"
                                                self.map.addAnnotation(objectAnnotation)
                                                
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
                        }
                        
                    }
                }
            }
        }

        
        
        
        if (driverEnroute == false) {
        
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
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "logoutRider" {
            
            locationManager.stopUpdatingLocation()
            
            PFUser.logOut()
            
        }
        
    }
    

    
    
}
