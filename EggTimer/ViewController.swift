//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

var doneSound: AVAudioPlayer?

class ViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    
    
    let eggTimes = ["Soft": 3, "Medium": 7, "Hard": 12]
    
    // Create a Timer instance
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        // Stopping previous timer, this prevents
        // any chance of two timers running at the
        // same time
        timer.invalidate()
        
        if let hardness = sender.currentTitle, let eggTime = eggTimes[hardness] {
            let totalTime = Float(eggTime)
            var secondsPassed: Float = 0.0
            
            progressBar.progress = 0.0
            titleLabel.text = hardness
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                secondsPassed += 1.0
                self.progressBar.progress = secondsPassed / totalTime
                
                if secondsPassed >= totalTime {
                    timer.invalidate()
                    self.titleLabel.text = "Done!"
                    self.progressBar.progress = 1.0
                    
                    guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
                    
                    do {
                        doneSound = try AVAudioPlayer(contentsOf: url)
                        doneSound?.play()
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
