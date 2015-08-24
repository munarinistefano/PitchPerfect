//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Stefano Munarini on 8/22/15.
//  Copyright © 2015 Stefano Munarini. All rights reserved.
//
import AVFoundation
import UIKit

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var myAudioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerlayerNode: AVAudioPlayerNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        //let pathArray = [dirPath, "my_audio.waw"]
        //let pathArray = [dirPath, "22082015-165303.waw"]
        //let filePath = NSURL.fileURLWithPathComponents(pathArray)
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
            audioPlayer.enableRate = true
        } catch {
            
        }
        /*if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
        
            let filePathUrl = NSURL.fileURLWithPath(filePath)
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl)
                 audioPlayer.enableRate = true
            } catch {
                
            }
        } else {
            print("Error retriving filePath")
        }*/
        
        //Create an AVAudioFile
        do {
            myAudioFile = try AVAudioFile(forReading: receivedAudio.filePathUrl);
        } catch{
            
        }
        
        //Create the audioEngine
        audioEngine = AVAudioEngine()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PlaySlow(sender: UIButton) {
        //Play audio slow
        playSound(0.0, rate: 0.5)
    }
    
    @IBAction func PlayFast(sender: UIButton) {
        //Play audio fast
        playSound(0.0,rate: 1.5)
    }
    
    @IBAction func PlayChipmunk(sender: UIButton) {
        playAudioWithPitch(1000);
    }
    
    @IBAction func playDarthVader(sender: UIButton) {
        playAudioWithPitch(-1000);
    }
    
    @IBAction func StopAudio(sender: UIButton) {
        //Stop audio
        audioPlayer.stop()
    }
    
    /*
    This function allow to pass the time from
    where to start the audio and the rate with
    which the audio will be play
    */
    func playSound(currentTime: NSTimeInterval, rate: Float) {
        audioPlayerlayerNode.stop()
        audioPlayer.stop()
        audioPlayer.currentTime = currentTime
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    /*
    This function allow to pass the pitch
    and play the sound with that pitch value
    */
    func playAudioWithPitch(pitch: Float){
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        //Create the audio player node
        //and connect to audio engine
        audioPlayerlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerlayerNode)
        
        //Create the time pitch, set it
        //and connect to audio engine
        let timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        audioEngine.attachNode(timePitch)
        
        //Connect audio player node to time pitch
        audioEngine.connect(audioPlayerlayerNode, to: timePitch, format: myAudioFile.processingFormat)
        //Connect time pitch to output node
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format: myAudioFile.processingFormat)
        
        //Schedule audio player node
        audioPlayerlayerNode.scheduleFile(myAudioFile, atTime: nil, completionHandler: nil)
        do{
            try audioEngine.start()
        } catch {
            
        }
        
        audioPlayerlayerNode.play()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
