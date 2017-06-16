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

    //for button sound
    var buttonSound: AVAudioPlayer!
    
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
    }
    
    //IBAction to play sound when button is pressed(drag from here to button to link IBAction to button)
    @IBAction func buttonPressed(sender: Any) {
        playSound()
    }
    
    //function to play sound
    func playSound() {
        
        //if sound is already playing, then stop it
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
}

