//
//  AudioViewController.swift
//  PowerUpYourAnimations
//
//  Created by Marin Todorov on 6/11/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit

class AudioViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let r = CAReplicatorLayer()
    r.frame = view.bounds
    view.layer.addSublayer(r)

    let dot = CALayer()
    dot.bounds = CGRect(x: 0.0, y: 0.0, width: 5.0, height: 5.0)
    dot.position = CGPoint(x: 18.0, y: view.center.y)
    dot.backgroundColor = UIColor.greenColor().CGColor
    dot.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
    dot.borderWidth = 1.0
    dot.cornerRadius = 2.0
    r.addSublayer(dot)

    UIView.animateWithDuration(0.5, delay: 0.0, options: [.CurveEaseOut, .Repeat, .Autoreverse, .FillModeForwards], animations: {
      dot.transform = CATransform3DMakeScale(1.4, 10, 1.0)
      dot.backgroundColor = UIColor.cyanColor().CGColor

      }, completion: nil)
    dot.transform = CATransform3DIdentity

    r.instanceCount = 35
    r.instanceTransform = CATransform3DMakeTranslation(20.0, 0.0, 0.0)
    r.instanceDelay = 0.1
    
    UIView.animateWithDuration(1.25, delay: 0.0, options: [.Repeat, .Autoreverse], animations: {
      r.instanceTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
      }, completion: nil)

  }
  
}

extension AudioViewController: StarterProjectCode {
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    markAsSeen(self)
  }
}