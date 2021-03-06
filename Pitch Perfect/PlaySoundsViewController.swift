//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jeremy Peronto on 6/10/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer : AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slowButtonDidPress(sender: UIButton) {
        playAudioWithVariableRate(0.5)
    }
    
    @IBAction func fastButtonDidPress(sender: UIButton) {
        playAudioWithVariableRate(1.5)
    }
    
    func playAudioWithVariableRate(rate: Float){
        
        resetAudioEngineAndPlayer()
        
        audioPlayer.currentTime = 0
        audioPlayer.play()
        audioPlayer.rate = rate
    }
    
    @IBAction func chipmunkButtonDidPress(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func darthVaderButtonDidPress(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    func playAudioWithVariablePitch(pitch: Float){
        
        resetAudioEngineAndPlayer()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    func resetAudioEngineAndPlayer() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func stopButtonDidPress(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
    }
}
