//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Balaji Paulrajan on 6/2/15.
//  Copyright (c) 2015 Balaji Paulrajan. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    //Globals
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }
    
    @IBAction func playSoundAsFast(sender: UIButton) {
        playSoundWithVariableRate(2)
    }
    @IBAction func playSoundAsSlow(sender: UIButton) {
        playSoundWithVariableRate(0.5)
    }

    @IBAction func playSoundAsChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func playSoundAsDarthvader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopAudioPlayer(sender: UIButton) {
        stopEngineAndPlayer()
    }
    
    @IBAction func playSoundAsEcho(sender: UIButton) {
        var echoNode = AVAudioUnitDelay()
        echoNode.delayTime = NSTimeInterval(0.3)
        playAudioWithEffect(echoNode)
    }
    
    @IBAction func playSoundAsReverb(sender: UIButton) {
        var reverbNode = AVAudioUnitReverb()
        reverbNode.loadFactoryPreset( AVAudioUnitReverbPreset.Cathedral)
        reverbNode.wetDryMix = 60
        playAudioWithEffect(reverbNode)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        playAudioWithEffect(changePitchEffect)
       
    }
    
    func playAudioWithEffect(effect:AVAudioNode) {
        stopEngineAndPlayer()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(effect)
        audioEngine.connect(audioPlayerNode, to: effect, format: nil)
        audioEngine.connect(effect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    func playSoundWithVariableRate(rate:Float) {
        stopEngineAndPlayer()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play();
    }
    
    func stopEngineAndPlayer() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }

}
