//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by Stefano Munarini on 8/21/15.
//  Copyright © 2015 Stefano Munarini. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    //The model
    var recordedAudio: RecordedAudio!
    //The audio recorder class
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        //Hide stop button
        stopButton.hidden = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var microphoneButton: UIButton!
    
    /*
        Start recording
    */
    @IBAction func recordAudio(sender: UIButton) {
        //Show/Hide recording... label
        recordingLabel.text = "Recording..."
        //Show stop button
        stopButton.hidden = false
        //Disable microphone button
        microphoneButton.enabled = false
        print("Recording audio")
        
        RecordAudio()
    }
    
    /*
        Stop recording
    */
    @IBAction func stopRecording(sender: UIButton) {

        recordingLabel.text = "Tap to Record"
        //Hide stop button
        stopButton.hidden = true
        //Enable microphone button
        microphoneButton.enabled = true
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setActive(false)
        } catch {
            
        }
    }
    
    func RecordAudio(){
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        
        /*let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMYYYY-HHmmss"
        
        let recordName = formatter.stringFromDate(date)+".waw"
        let pathArray = [dirPath,recordName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)*/
        let pathArray = [dirPath,"my_audio.waw"]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            
        }
        
        let setting = [String : Int]()
        
        do {
            try audioRecorder = AVAudioRecorder(URL: filePath!, settings: setting)
        } catch {
            
        }
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag){
            recordedAudio = RecordedAudio(title: recorder.url.lastPathComponent!, filePathUrl: recorder.url)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            print("Unseccessfully audioRecorderDidFinishRecording")
        }
    }
}

