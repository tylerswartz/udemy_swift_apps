//
//  ViewController.swift
//  Downloading Img from Web
//
//  Created by Tyler Swartz on 12/1/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Johann_Sebastian_Bach.jpg/260px-Johann_Sebastian_Bach.jpg")
        
        let urlRequest = NSURLRequest(URL: url!)
    
    
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            if error != nil {
                print (error)
            } else {
                if let bach = UIImage(data: data!) {
                    self.image.image = bach
                    
                    // save the image
                    var documentsDirectory:String?
                    
                    var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                    
                    if paths.count > 0 {
                        
                        documentsDirectory = paths[0] as? String
                        
                        var savePath = documentsDirectory! + "/bach.jpg"
                        
                        NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                        
                    }
                    
                /*
                    //to create image from saved file path
                    self.image.image = UIImage(named: savePath)
                */
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

