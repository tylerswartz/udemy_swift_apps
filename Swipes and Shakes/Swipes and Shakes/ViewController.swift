//
//  ViewController.swift
//  Swipes and Shakes
//
//  Created by Tyler Swartz on 11/29/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Detect Swipes
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        
    }
    
    // detect and shake action
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        if event?.subtype == UIEventSubtype.MotionShake {
            
            print("device was shaken")
            
        }
        
    }
    

    
    //action taken based on shake
    func swiped(gesture: UIGestureRecognizer){
        
        // check if it is in fact a swipe
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            //switch replaces an if else statement
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.Right:
                print("swiped right")
                
            case UISwipeGestureRecognizerDirection.Up:
                print("swiped up")
                
            // catch all is needed at the end
            default:
                break
                
            }
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

