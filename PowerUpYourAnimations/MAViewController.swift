//
//  ViewController.swift
//  MarchingAnts
//
//  Created by Marin Todorov on 6/10/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit

class MAViewController: UIViewController {
  
  let selection = CAShapeLayer()
  @IBOutlet weak var photo: UIImageView!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    // configure the appearance of the selection
    
    selection.fillColor = UIColor(red: 1, green: 1, blue: 0, alpha: 0.2).CGColor
    selection.strokeColor = UIColor.whiteColor().CGColor
    selection.lineWidth = 3.0
    selection.shadowOpacity = 0.25
    selection.shadowOffset = CGSize(width: 1, height: 1)
    selection.shadowRadius = 0.1
    
    photo.layer.addSublayer(selection)
    
    //configure the dash pattern
    selection.lineDashPattern = [5, 3]

    //add the marching ants animation
    UIView.animateWithDuration(0.5, delay: 0.0, options: [.CurveLinear, .Repeat], animations: {
      self.selection.lineDashPhase = 8.0
      }, completion: nil)

  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesMoved(touches, withEvent: event)
    
    // make the selection frame rect
    let location = touches.first!.locationInView(photo)
    let selectionRect = CGRect(
      x: photo.bounds.size.width/2 - abs(location.x - photo.bounds.size.width/2),
      y: photo.bounds.size.height/2 - abs(location.y - photo.bounds.size.height/2),
      width: 2 * abs(location.x - photo.bounds.size.width/2),
      height: 2 * abs(location.y - photo.bounds.size.height/2)
    )
    
    selection.path = UIBezierPath(rect: selectionRect).CGPath
  }
  
}

extension MAViewController: StarterProjectCode {
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    markAsSeen(self)
  }
}

