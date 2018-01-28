//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ryan Berry on 2/2/17.
//  Copyright © 2017 Ryan Berry. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var stopRecording: UIButton!
    @IBOutlet weak var recording: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    func startStopRecording(isRecording: Bool){
    
        recordingLabel.text = isRecording ? "Recording in progress" : "Tap to record"
        recording.isEnabled = !isRecording
        stopRecording.isEnabled = isRecording
    }
        
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopRecording.isEnabled = false
    }
    
    
    @IBAction func recordAudio(_ sender: Any) {
    
        startStopRecording(isRecording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
  
        
    }
    
    
    @IBAction func stopRecordingButton(_ sender: Any) {
        
        startStopRecording(isRecording: false)
        
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
 
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag {
           performSegue(withIdentifier:"stopRecording", sender: audioRecorder.url)
        } else {
            print(" recording was not succesfull ")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
        
    }
        
        
        
}
    

    
