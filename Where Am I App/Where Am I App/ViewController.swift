//
//  ViewController.swift
//  Where Am I App
//
//  Created by Tyler Swartz on 11/15/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lngLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var altLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var manager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //identify location
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //set map and pull locations
        
        var userLocation:CLLocation = locations[0]
        
        var latitude = userLocation.coordinate.latitude
        
        var longitude = userLocation.coordinate.longitude
        
        var speed = ((userLocation.speed) * 2.23694) //convert from meters per second to MPH
        
        var alt = userLocation.altitude //in meters
        
        var course = userLocation.course
        
        var latDelta:CLLocationDegrees = 0.01
        
        var longDelta:CLLocationDegrees = 0.01
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: true)
        
        //update labels
        self.latLabel.text = String(format: "%.6f", latitude)
        
        self.lngLabel.text = String(format: "%.6f", longitude)
        
        self.speedLabel.text = String(format: "%.2f", speed) + " mph"
        
        self.courseLabel.text = String(course) + " degrees"
        
        self.altLabel.text = String(alt) + " meters"
                
        
        //Geo location to find locale address
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                print(error)
                
            } else {
                
                if let p = placemarks?[0] {
                    
                    var subThoroughfare:String = ""
                    var thoroughfare:String = ""
                    var subLocality:String = ""
                    var subAdministrativeArea:String = ""
                    var postalCode:String = ""
                    var country:String = ""
                    
                    if (p.subThoroughfare != nil) {
                        
                        subThoroughfare = p.subThoroughfare!
                        
                    }
                    
                    if (p.thoroughfare != nil) {
                        
                        thoroughfare = p.thoroughfare!
                        
                    }
                    
                    if (p.subLocality != nil) {
                        
                        subLocality = p.subLocality!
                        
                    }
                    
                    if (p.subAdministrativeArea != nil) {
                        
                        subAdministrativeArea = p.subAdministrativeArea!
                        
                    }
                    
                    if (p.postalCode != nil) {
                        
                        postalCode = p.postalCode!
                        
                    }
                    
                    if (p.country != nil) {
                        
                        country = p.country!
                        
                    }
                    
                    
                    self.addressLabel.text = "\(subThoroughfare) \(thoroughfare) \n \(subLocality) \n \(subAdministrativeArea) \n \(postalCode) \n \(country)"
                    
                }
                
                
            }
        
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

