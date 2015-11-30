//
//  ViewController.swift
//  Animations
//
//  Created by Tyler Swartz on 11/8/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pandaImg: UIImageView!
    
    
    var counter = 0
    
    var timer  = NSTimer()
    
    var isAnimating = true
    
    @IBAction func updateImgButton(sender: AnyObject) {

        
        
    }
    
    

    @IBAction func startStopButton(sender: AnyObject) {

        if isAnimating == true {
            
            timer.invalidate()
            
            isAnimating = false
            
        } else {
            
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "doAnimation", userInfo: nil, repeats: true)
            
            isAnimating = true
            
        }
        
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "doAnimation", userInfo: nil, repeats: true)
        
    }

    
    func doAnimation() {
        
        if counter == 19 {
            
            counter = 1
            
        } else {
            
            counter++
            
        }
        
        pandaImg.image = UIImage(named: "frames\(counter).png")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

/*
    
    // Runs just before the view loads. Basiaclly everything has compiled but the final view for the user has not yet loaded.
    override func viewDidLayoutSubviews() {
        
//        pandaImg.center = CGPointMake(pandaImg.center.x - 400, pandaImg.center.y)
        
//        pandaImg.alpha = 0
        
//        pandaImg.frame = CGRectMake(100, 20, 0, 0)
        
    }
    
    // Called just when the view loads. So the moment the user can see the screen load.
    override func viewDidAppear(animated: Bool) {
     
        UIView.animateWithDuration(1) { () -> Void in
            
//            self.pandaImg.center = CGPointMake(self.pandaImg.center.x + 400, self.pandaImg.center.y)
            
//            self.pandaImg.alpha = 1
            
//            self.pandaImg.frame = CGRectMake(100, 20, 100, 100)
        }
        
    }

*/
    

}
