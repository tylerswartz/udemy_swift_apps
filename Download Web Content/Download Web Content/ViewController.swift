//
//  ViewController.swift
//  Download Web Content
//
//  Created by Tyler Swartz on 10/25/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //note if URL below is not httpS then you need to modify Plist file to allow non-secure connection        
        let url = NSURL(string: "http://stackoverflow.com")!
        
        
//To display a url in webview without downloading:
        webView.loadRequest(NSURLRequest(URL: url))
        
        
/* Download then load data into the webview
        
        // Define what the api call is
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            // Code below will execute when task completes
            
            // Check if data exists and has content
            if let urlContent = data {
                
                // Format data response
                let webContent = NSString( data: urlContent, encoding: NSUTF8StringEncoding)
                
                //Async load to display content quicker
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    // load into web view
                    self.webView.loadHTMLString(String(webContent!), baseURL: nil)
                    
                })
                
            } else {
               
                // Show error message that no connection was made
            
            }
            
            
        }
        
        // Runs the task
        task.resume()
*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

