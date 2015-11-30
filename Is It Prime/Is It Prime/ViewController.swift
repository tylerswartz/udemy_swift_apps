//
//  ViewController.swift
//  Is It Prime
//
//  Created by Tyler Swartz on 10/18/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var inputNumberBox: UITextField!
    
    @IBOutlet weak var textAnswer: UILabel!
    
    @IBAction func buttonPrimeCheck(sender: AnyObject) {
    
        if let number = Int(inputNumberBox.text!) {
            
            var isPrime = true
            
            if number == 1 {
                
                isPrime = false
            }
            
            if number != 2 && number != 1 {
                
                for var i = 2; i < number; i++ {
                    
                    if number % i == 0 {
                        
                        isPrime = false
                        
                    }
                    
                }
                
            }
            
            if isPrime {
                
                textAnswer.text = "\(number) is prime! 😄"
                
            } else {
                
                textAnswer.text = "\(number) is not prime. 😞"
                
            }
            
        } else {
            
            textAnswer.text = "Please enter a whole number."
            
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

