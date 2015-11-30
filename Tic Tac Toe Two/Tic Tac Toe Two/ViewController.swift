//
//  ViewController.swift
//  Tic Tac Toe Two
//
//  Created by Tyler Swartz on 11/8/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var button: UIButton!
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
    
        sender.setImage(UIImage(named: "nought.png"), forState: .Normal)
        
    
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

