//
//  ViewController.swift
//  Calculator
//
//  Created by Nishant on 16/06/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var outputLabel: UILabel!

    //for button sound
    var buttonSound: AVAudioPlayer!
    
    //enum for various operations
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = ""
    }
    
    //current operation
    var currentOperation = Operation.Empty
    
    //2(leftHandValue) +(operator) 2(rightHandVlaue) =(operator) 4(result)
    var result: String = ""
    var runningNumber: String = ""
    var leftHandValue: String = ""
    var rightHandValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //path for "btn.wav" file, i.e buttonSound file
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        //URL for sound, iOS uses URL instead of path
        let soundURL = URL(fileURLWithPath: path!)
        
        //error handling for button sound
        do {
            try buttonSound = AVAudioPlayer(contentsOf: soundURL)
            buttonSound.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        outputLabel.text = "0"
    }
    
    //IBAction to play sound when button is pressed(drag from here to button to link IBAction to button)
    @IBAction func buttonPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    //function to play sound
    func playSound() {
        
        //if sound is already playing, then stop it
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
    //functions for operator buttons
    @IBAction func dividePressed(sender: Any) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func multiplyPressed(sender: Any) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func subtractPressed(sender: Any) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func addPressed(sender: Any) {
        processOperation(operation: .Add)
    }
    
    @IBAction func equalPressed(sender: Any) {
        processOperation(operation: currentOperation)
    }
    
    //function to process the operation selected, is called from IBActions of the operator buttons
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            
            //if user selected two operators consecutively, i.e two operations are performed continuously 
            //without pressing equals after first operation
            if runningNumber != "" {
                
                //since "leftHandValue" is already provided, current value of "runningNumber" is "rightHandValue"
                rightHandValue = runningNumber
                
                runningNumber = ""
                
                if currentOperation == Operation.Divide {
                    result = "\(Double(leftHandValue)! / Double(rightHandValue)!)"
                } else if currentOperation == Operation.Multiply {
                    result = "\(Double(leftHandValue)! * Double(rightHandValue)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftHandValue)! - Double(rightHandValue)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftHandValue)! + Double(rightHandValue)!)"
                }
                
                leftHandValue = result
                outputLabel.text = result
            }
            
            currentOperation = operation
        } else {    //when an operation is performed for the firsr time
            
            //"runningNumber" is put in the "leftHandValue"
            leftHandValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
    }
    
    //function for clear button(clears all variables and operations)
    @IBAction func clearPressed(_ sender: Any) {
        outputLabel.text = "0"
        result = ""
        runningNumber = ""
        leftHandValue = ""
        rightHandValue = ""
        currentOperation = Operation.Empty
    }

}

