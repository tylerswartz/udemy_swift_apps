//
//  ViewController.swift
//  Memborable Places
//
//  Created by Tyler Swartz on 11/23/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    var manager: CLLocationManager!
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        if activePlace == -1 {
            
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
            
        } else {
            
            let latitude = NSString(string: places[activePlace]["lat"]!).doubleValue
            let longitude = NSString(string: places[activePlace]["long"]!).doubleValue
            
            var coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            var latDelta:CLLocationDegrees = 0.01
            var longDelta:CLLocationDegrees = 0.01
            var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            var region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
            self.map.setRegion(region, animated: false)
            
            var annotation = MKPointAnnotation()
            
            annotation.coordinate = coordinate
            
            annotation.title = places[activePlace]["name"]
            
            self.map.addAnnotation(annotation)
            
        }
        
        
        
        
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        uilpgr.minimumPressDuration = 2.0
        
        map.addGestureRecognizer(uilpgr)
    
    }

    func action(gestureRecognizer:UIGestureRecognizer) {
        
        //looks for first long press, so only one action per that long press
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
        
            var touchPoint = gestureRecognizer.locationInView(self.map)
            
            var newCoordinate = self.map.convertPoint(touchPoint, toCoordinateFromView: self.map)
            
            var location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
                var title = ""
                
                if (error == nil) {
                    
                    if let p = placemarks?[0] {
                        
                        var subThoroughfare:String = ""
                        var thoroughfare:String = ""
                        
                        if p.subThoroughfare != nil {
                            
                            subThoroughfare = p.subThoroughfare!
                            
                        }
                        
                        if p.thoroughfare != nil {
                            
                            thoroughfare = p.thoroughfare!
                            
                        }
                        
                        title = "\(subThoroughfare) \(thoroughfare)"
                        
                    }
                    
                    
                }
                
                if title == "" {
                    
                    title = "Added \(NSDate())"
                }
                
                places.append(["name":title,"lat":"\(newCoordinate.latitude)","long":"\(newCoordinate.longitude)"])
                
                var annotation = MKPointAnnotation()
                
                annotation.coordinate = newCoordinate
                
                annotation.title = title
                
                self.map.addAnnotation(annotation)
                
            })
            
            
            
            
            
        }
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var userLocation:CLLocation = locations[0]
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        var coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        var latDelta:CLLocationDegrees = 0.01
        var longDelta:CLLocationDegrees = 0.01
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        self.map.setRegion(region, animated: false)
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

