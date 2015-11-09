//
//  AudioMonitor.swift
//  PlayerMeter
//
//  Created by Marin Todorov on 8/10/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import Foundation
import AVFoundation

class AudioMonitor: NSObject, AVAudioPlayerDelegate {

  var didFinishPlaying: (()->Void)?
  
  private var levelsHandler: ((Float, Float)->Void)?
  private var timer: NSTimer?
  
  var player: AVAudioPlayer?
  
  convenience init(levelsHandler lh: (Float, Float)->Void) {
    self.init()
    levelsHandler = lh
  }
  
  func play(fileNamed: String) {
    stop()
    
    let fileURL = NSBundle.mainBundle().URLForResource(fileNamed, withExtension: nil)
    try! player = AVAudioPlayer(contentsOfURL: fileURL!)
    player?.meteringEnabled = true
    player?.delegate = self
    player?.play()

    //start meters
    timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: "handleAudioLevels:", userInfo: nil, repeats: true)
  }
  
  func stop() {
    player?.stop()
    stopMonitoring()
  }
  
  func stopMonitoring() {
    timer?.invalidate()
  }
  
  func handleAudioLevels(timer: NSTimer) {
    if player == nil {
      return
    }
    player!.updateMeters()
    levelsHandler?(player!.averagePowerForChannel(0), player!.averagePowerForChannel(1))
  }
  
  deinit {
    levelsHandler = nil
    stop()
  }
  
  //MARK: - AVAudioPlayerDelegate
  func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
    didFinishPlaying?()
  }
}