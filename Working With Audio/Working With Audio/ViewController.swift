//
//  ViewController.swift
//  Working With Audio
//
//  Created by Tyler Swartz on 11/29/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    var player:AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func play(sender: AnyObject) {
    
        player.play()
    
    }
    
    
    @IBAction func pause(sender: AnyObject) {
    
        player.pause()
    
    }
    
    
    @IBAction func adjustVolume(sender: AnyObject) {
    
        player.volume = slider.value
        
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let audioPath = NSBundle.mainBundle().pathForResource("FMLYBND- Letting Go", ofType: "mp3")!
        
        do {
            
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
            
            
        } catch {
            
            // process error here
            print("error for file")
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

