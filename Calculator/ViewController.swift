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

    var buttonSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOf: soundURL)
            buttonSound.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    @IBAction func buttonPressed(sender: Any) {
        playSound()
    }
    
    func playSound() {
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
}

