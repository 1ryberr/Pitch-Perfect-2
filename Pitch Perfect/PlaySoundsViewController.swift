//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ryan Berry on 2/4/17.
//  Copyright © 2017 Ryan Berry. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {
    
    var recordedAudioURL: URL!
    
    
    @IBOutlet weak var sloButton: UIButton!
    
    @IBOutlet weak var fastButton: UIButton!
    
    @IBOutlet weak var highPitch: UIButton!
    
    @IBOutlet weak var lowPitch: UIButton!
    
    @IBOutlet weak var echoButton: UIButton!
    
    @IBOutlet weak var reverbButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    
    var recordedAudio: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int{case slow = 0, fast, chipmunk, vader, echo, reverb }
    
    @IBAction func playSounds(_ sender: UIButton){
        
        switch(ButtonType(rawValue: sender.tag)!) {
            
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
            
        }
        
        configureUI(.playing)
        
    }
    
    @IBAction func stopSounds(_ sender: UIButton){
        
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    

}
