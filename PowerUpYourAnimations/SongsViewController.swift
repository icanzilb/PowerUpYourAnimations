//
//  SongsViewController.swift
//  Streamify
//
//  Created by Marin Todorov on 8/13/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit

class SongsViewController: UIViewController {
  
  var playlist: PlaylistModel!
  
  @IBOutlet weak var displayView: UIView!
  
  var audio: AudioMonitor!
  
  deinit {
    audio?.stop()
  }
}

extension SongsViewController {
  
  func createMeter() -> CAReplicatorLayer {
    
    let meter = CAReplicatorLayer()
    meter.frame = CGRect(x: 0, y: 0,
      width: view.frame.size.width * 0.48,
      height: 120)
    
    let bar = CALayer()
    bar.backgroundColor = UIColor.whiteColor().CGColor
    bar.frame = CGRect(x: 0, y: 118,
      width: view.frame.size.width * 0.48, height: 2)
    meter.addSublayer(bar)
    
    meter.instanceCount = 40
    meter.instanceTransform =
      CATransform3DMakeTranslation(0, -3, 0)
    meter.instanceColor = UIColor.greenColor().CGColor
    meter.instanceGreenOffset = -0.02
    meter.instanceRedOffset = 0.02
    
    return meter
  }
  
  func setupMeter() {
    let leftMeter = createMeter()
    displayView.layer.addSublayer(leftMeter)
    
    let rightMeter = createMeter()
    rightMeter.frame.origin.x = view.bounds.size.width * 0.51
    displayView.layer.addSublayer(rightMeter)
    
    audio = AudioMonitor(
      levelsHandler: {left, right in
        
        let leftCount = max(0, Int(left) + 45)
        leftMeter.instanceCount = leftCount
        
        let rightCount = max(0, Int(right) + 45)
        rightMeter.instanceCount = rightCount
        
    })
  }
}

// MARK: - Starter project code
extension SongsViewController: StarterProjectCode {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = playlist.name
    
    displayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "actionVisualizer:"))
    
    setupMeter()
  }
  
  func actionVisualizer(tap: UITapGestureRecognizer) {
    performSegueWithIdentifier("showVisualizer", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  }
}

extension SongsViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView.restorationIdentifier == "PlaylistTable" {
      return 1
    } else {
      return playlist.songs.count
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if tableView.restorationIdentifier == "PlaylistTable" {
      let cell = tableView.dequeueReusableCellWithIdentifier("PlaylistCell") as! PlaylistCell
      
      cell.name.text = playlist.name
      cell.style.text = playlist.style
      cell.songs.text = "\(playlist.songs.count) songs"
      
      return cell
    } else {
      let cell = tableView.dequeueReusableCellWithIdentifier("SongCell")!
      
      cell.textLabel!.text = "\(indexPath.row+1). " + playlist.songs[indexPath.row]
      
      return cell
    }
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if audio == nil {
      setupMeter()
    }
    
    if tableView.restorationIdentifier != "PlaylistTable" {
      audio?.play(playlist.songs[indexPath.row])
    }
  }
}