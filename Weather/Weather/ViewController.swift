//
//  ViewController.swift
//  Weather
//
//  Created by Tyler Swartz on 10/26/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputCity: UITextField!

    @IBOutlet weak var labelWeather: UITextView!
    
    @IBAction func buttonGetWeather(sender: AnyObject) {
    
        var wasSuccessful = false
        
        // Define URL to be called
        let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + inputCity.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = attemptedUrl {
        
        // Define what the api call is
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            // Code below will execute when task completes
            
            // Check if data exists and has content
            if let urlContent = data {
                
                // Format data response
                let webContent = NSString( data: urlContent, encoding: NSUTF8StringEncoding)
                
                let webSiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if webSiteArray.count > 1 {
                    
                    let weatherArray = webSiteArray[1].componentsSeparatedByString("</span>")
                    
                    if weatherArray.count > 1 {
                        
                        wasSuccessful = true
                        
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        //Async load to display content quicker
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            // load into web view
                            self.labelWeather.text = weatherSummary
                            
                        })
                        
                        
                    }
                    
                    
                }
                
                
                
                
                //            } else {
                
                // Show error message that no connection was made
                
            }
            
            if wasSuccessful == false {
                self.labelWeather.text = "Couldn't find the weather for that city. Please try again."
            }
            
            
            
        }
        
            
        // Runs the task
        task.resume()
        
        } else {
            
            self.labelWeather.text = "Couldn't find the weather for that city. Please try again."
            
        }
    
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

