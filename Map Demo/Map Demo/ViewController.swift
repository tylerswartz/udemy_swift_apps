//
//  ViewController.swift
//  Map Demo
//
//  Created by Tyler Swartz on 11/15/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Ask user location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        var latitude:CLLocationDegrees = 37.8019022
        
        var longitude:CLLocationDegrees = -122.4662118
        
        var latDelta:CLLocationDegrees = 0.01
        
        var longDelta:CLLocationDegrees = 0.01
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        
        annotation.title = "Presidio"
        
        annotation.subtitle = "California"
        
        map.addAnnotation(annotation)
        
        
        // Allow long-press to add a pin
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "longPress:")
        
        uilpgr.minimumPressDuration = 2
        
        map.addGestureRecognizer(uilpgr)
        
        
    }

    
    func longPress(gestureRecognizer:UIGestureRecognizer) {
        
        var touchPoint = gestureRecognizer.locationInView(self.map)
        
        var newCoordinate:CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        
        var annotation = MKPointAnnotation()
        
        annotation.coordinate = newCoordinate
        
        annotation.title = "New Place"
        
        map.addAnnotation(annotation)
        

        
        
    }
    
    //allows us to access the locations when the user is updated.
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        var userLocation:CLLocation = locations[0]
        
        var latitude = userLocation.coordinate.latitude
        
        var longitude = userLocation.coordinate.longitude
        
        var latDelta:CLLocationDegrees = 0.01
        
        var longDelta:CLLocationDegrees = 0.01
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: true)
        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

