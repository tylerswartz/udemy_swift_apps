//
//  ViewController.swift
//  Webviews
//
//  Created by Tyler Swartz on 12/2/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webviewOutlet: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var url = NSURL(string:"http://swartz.cc")
        
        var request = NSURLRequest(URL: url!)
        
        webviewOutlet.loadRequest(request)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

