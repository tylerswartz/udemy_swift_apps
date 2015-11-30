//
//  ViewController.swift
//  How Many Fingers
//
//  Created by Tyler Swartz on 10/13/15.
//  Copyright © 2015 swartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textGuessLeft: UILabel!
    
    @IBOutlet weak var textAnswer: UILabel!
    
    @IBOutlet weak var inputGuess: UITextField!
    
    @IBOutlet weak var buttonPlayAgain: UIButton!
    
    
    var randNum:Int = Int(arc4random_uniform(10) + 1)
    var guessCounter = 3
    
    
    @IBAction func buttonGuess(sender: AnyObject) {
        let guess = Int(inputGuess.text!)
        
        if guess == randNum {
            textAnswer.text = "Nice, you are right!"
            guessCounter -= 1
            if guessCounter != 1 {
                textGuessLeft.text = "\(guessCounter) guesses left"
            } else {
                textGuessLeft.text = "1 guess left"
            }
            buttonPlayAgain.hidden = false
        } else if guess > randNum && guessCounter > 1 {
            textAnswer.text = "Too high. Try again"
            inputGuess.text=""
            guessCounter -= 1
            if guessCounter == 1 {
                textGuessLeft.text = "\(guessCounter) guess left"
            } else {
                textGuessLeft.text = "\(guessCounter) guesses left"
            }
        } else if guess < randNum && guessCounter > 1 {
            textAnswer.text = "Too low. Try again"
            inputGuess.text=""
            guessCounter -= 1
            if guessCounter == 1 {
                textGuessLeft.text = "\(guessCounter) guess left"
            } else {
                textGuessLeft.text = "\(guessCounter) guesses left"
            }
        } else {
            textGuessLeft.text = "0 guesses left"
            textAnswer.text = "Sorry, the number was \(randNum)"
            buttonPlayAgain.hidden = false
        }
        
        inputGuess.resignFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonPlayAgain.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

