//
//  SpinnerViewController.swift
//  PowerUpYourAnimations
//
//  Created by Marin Todorov on 10/1/15.
//  Copyright © 2015 Underplot ltd. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //add a replicator layer with black background
    let replicator = CAReplicatorLayer()
    replicator.bounds = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0)
    replicator.cornerRadius = 10.0
    replicator.backgroundColor = UIColor(white: 0.0, alpha: 0.75).CGColor
    replicator.position = view.center
    
    view.layer.addSublayer(replicator)
    
    //create the original layer
    let dot = CALayer()
    dot.bounds = CGRect(x: 0.0, y: 0.0, width: 14.0, height: 14.0)
    dot.position = CGPoint(x: 100.0, y: 40.0)
    dot.backgroundColor = UIColor(white: 0.8, alpha: 1.0).CGColor
    dot.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
    dot.borderWidth = 1.0
    dot.cornerRadius = 2.0
    
    replicator.addSublayer(dot)
    
    //set number of copies
    let nrDots: Int = 15
    replicator.instanceCount = nrDots
    
    //calculate the angle
    let angle = CGFloat(2*M_PI) / CGFloat(nrDots)
    replicator.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
    
    //shrink animation
    let duration: CFTimeInterval = 1.5
    
    let shrink = CABasicAnimation(keyPath: "transform.scale")
    shrink.fromValue = 1.0
    shrink.toValue = 0.1
    shrink.duration = duration
    shrink.repeatCount = Float.infinity
    
    dot.addAnimation(shrink, forKey: nil)
    dot.transform = CATransform3DMakeScale(0.01, 0.01, 0.01)
    
    //set delay between copies
    replicator.instanceDelay = duration/Double(nrDots)
  }
}