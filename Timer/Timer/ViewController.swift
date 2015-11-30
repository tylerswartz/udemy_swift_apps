//
//  ViewController.swift
//  Timer
//
//  Created by Tyler Swartz on 10/18/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = NSTimer()
    
    var time = 0
    
    var hours = 0
    
    var minutes = 0
    
    var seconds = 0
    
    @IBOutlet weak var timerLabel: UILabel!
    
    func result(){
        
        time++
            
        hours = time / 3600
        
        minutes = (time % 3600) / 60
            
        seconds = (time % 3600) % 60
        
        timerLabel.text = (String(format: "%02d", hours)) + ":" + (String(format: "%02d", minutes)) + ":" + (String(format: "%02d", seconds))
        
    }
    
    @IBAction func startTimer(sender: AnyObject) {
    
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("result"), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func stopTimer(sender: AnyObject) {
    
        timer.invalidate()
        
    }
    
    @IBAction func resetTimer(sender: AnyObject) {

        timer.invalidate()
        
        time = 0
        
        timerLabel.text = "00:00:00"
    
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

