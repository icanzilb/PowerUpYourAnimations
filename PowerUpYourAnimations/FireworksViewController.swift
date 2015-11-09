//
//  FireworksViewController.swift
//  PowerUpYourAnimations
//
//  Created by Marin Todorov on 11/8/15.
//  Copyright © 2015 Underplot ltd. All rights reserved.
//

import UIKit

class FireworksViewController: UIViewController {
  let startPt = CGPoint(x: 160, y: 350)
  let endPt = CGPoint(x: 320, y: 140)

  let startPt2 = CGPoint(x: 600, y: 350)
  let endPt2 = CGPoint(x: 520, y: 180)
  
  var demoStep = 10
  
  func startAnimation() {
    //repeat
    delay(seconds: 5, completion: startAnimation)

    //spring animation
    animateBall(from: startPt, to: endPt)
    if demoStep == 0 {return}
    
    //layer animation
    animateLine(from: startPt, to: endPt)
    if demoStep == 1 {return}
    
    //replicator
    switch demoStep {
    case 2:
      delay(seconds: 1.1, completion: {self.firework1_1(at: self.endPt)})
    case 3:
      delay(seconds: 1.1, completion: {self.firework1_2(at: self.endPt)})
    case 4:
      delay(seconds: 1.1, completion: {self.firework1_3(at: self.endPt)})
    default:
      delay(seconds: 1.1, completion: {self.firework1_4(at: self.endPt)})
    }
    
    if demoStep == 2 || demoStep == 3 || demoStep == 4 || demoStep == 5 {return}
    
    //explosions
    explosions()
    
    if demoStep == 6 {return}

    delay(seconds: 0.5, completion: {self.animateBall(from: self.startPt2, to: self.endPt2)})
    delay(seconds: 0.5, completion: {self.animateLine(from: self.startPt2, to: self.endPt2)})
    delay(seconds: 1.6, completion: {self.firework2(at: self.endPt2)})
  }
  
  func explosions() {
    delay(seconds: 0.8, completion: {self.bang(color: UIColor.whiteColor(), at: CGPoint(x: 243.0, y: 91.5))})
    delay(seconds: 1.5, completion: {self.bang(color: UIColor.greenColor(), at: CGPoint(x: 216.5, y: 194.0))})
    delay(seconds: 2.2, completion: {self.bang(color: UIColor.whiteColor(), at: CGPoint(x: 443.0, y: 209.0))})
    delay(seconds: 2.8, completion: {self.bang(color: UIColor.cyanColor(), at: CGPoint(x: 429.0, y: 125.5))})
    delay(seconds: 3.2, completion: {self.bang(color: UIColor.whiteColor(), at: CGPoint(x: 281.5, y: 266.5))})
  }
  
  // 1) animate a view with spring animation
  func animateBall(from from: CGPoint, to: CGPoint) {
    //add ball
    let ballSize: CGFloat = 4.0
    let ball = UIView(frame: CGRect(x: 0, y: 0, width: ballSize, height: ballSize))
    ball.backgroundColor = UIColor.whiteColor()
    ball.layer.cornerRadius = ballSize/2
    ball.center = from
    view.addSubview(ball)
    
    //animate ball
    UIView.animateWithDuration(1.0, delay: 0.0, options: [.CurveEaseOut], animations: {
      ball.center = to
      }, completion: {_ in
      ball.removeFromSuperview()
    })
  }

  func animateLine(from from: CGPoint, to: CGPoint) {
    let linePath = UIBezierPath()
    linePath.moveToPoint(from)
    linePath.addLineToPoint(to)
    
    let line = CAShapeLayer()
    line.path = linePath.CGPath
    line.lineCap = kCALineCapRound
    line.strokeColor = UIColor.cyanColor().CGColor
    
    line.strokeStart = 0.0
    line.strokeEnd = 0.0

    view.layer.addSublayer(line)
    
    UIView.animateWithDuration(1.0, delay: 0.0, options: [.CurveEaseOut], animations: {
      line.strokeEnd = 1.0
      }, completion: nil)

    UIView.animateWithDuration(0.75, delay: 0.9, options: [.CurveEaseOut], animations: {
      line.strokeStart = 1.0
      }, completion: nil)
  }

  func firework1_1(at atPoint: CGPoint) {
    let replicator = CAReplicatorLayer()
    replicator.position = atPoint
    
    //line path
    let f11linePath = UIBezierPath()
    f11linePath.moveToPoint(CGPoint(x: 0, y: -10))
    f11linePath.addLineToPoint(CGPoint(x: 0, y: -100))
    
    let f11line = CAShapeLayer()
    f11line.path = f11linePath.CGPath
    f11line.strokeColor = UIColor.cyanColor().CGColor
    replicator.addSublayer(f11line)
    
    replicator.instanceCount = 20
    replicator.instanceTransform = CATransform3DMakeRotation(CGFloat(M_PI/10), 0, 0, 1)
    view.layer.addSublayer(replicator)
    
    delay(seconds: 2, completion: {replicator.removeFromSuperlayer()})
  }
  
  func firework1_2(at atPoint: CGPoint) {
    let replicator = CAReplicatorLayer()
    replicator.position = atPoint
    
    //line path
    let f11linePath = UIBezierPath()
    f11linePath.moveToPoint(CGPoint(x: 0, y: -10))
    f11linePath.addLineToPoint(CGPoint(x: 0, y: -100))
    
    let f11line = CAShapeLayer()
    f11line.path = f11linePath.CGPath
    f11line.strokeColor = UIColor.cyanColor().CGColor
    replicator.addSublayer(f11line)
    
    replicator.instanceCount = 20
    replicator.instanceTransform = CATransform3DMakeRotation(CGFloat(M_PI/10), 0, 0, 1)
    view.layer.addSublayer(replicator)
    
    f11line.strokeEnd = 0
    UIView.animateWithDuration(1.0, delay: 0.33, options: [.CurveEaseOut], animations: {
      f11line.strokeEnd = 1.0
      }, completion: nil)

    delay(seconds: 2, completion: {replicator.removeFromSuperlayer()})
  }
  
  func firework1_3(at atPoint: CGPoint) {
    let replicator = CAReplicatorLayer()
    replicator.position = atPoint
    
    //line path
    let f11linePath = UIBezierPath()
    f11linePath.moveToPoint(CGPoint(x: 0, y: -10))
    f11linePath.addLineToPoint(CGPoint(x: 0, y: -100))
    
    let f11line = CAShapeLayer()
    f11line.path = f11linePath.CGPath
    f11line.strokeColor = UIColor.cyanColor().CGColor
    replicator.addSublayer(f11line)
    
    replicator.instanceCount = 20
    replicator.instanceTransform = CATransform3DMakeRotation(CGFloat(M_PI/10), 0, 0, 1)
    
    f11line.strokeEnd = 0
    UIView.animateWithDuration(1.0, delay: 0.33, options: [.CurveEaseOut], animations: {
      f11line.strokeEnd = 1.0
      }, completion: nil)
    
    //line path 2
    let f12linePath = UIBezierPath()
    f12linePath.moveToPoint(CGPoint(x: 0, y: -25))
    f12linePath.addLineToPoint(CGPoint(x: 0, y: -100))
    f12linePath.applyTransform(CGAffineTransformMakeRotation(CGFloat(M_PI/20)))
    
    let f12line = CAShapeLayer()
    f12line.path = f12linePath.CGPath
    f12line.lineDashPattern = [20, 2]
    f12line.strokeColor = UIColor.cyanColor().CGColor
    replicator.addSublayer(f12line)
    
    f12line.strokeEnd = 0
    
    UIView.animateWithDuration(1.0, delay: 0.0, options: [.CurveEaseOut], animations: {
      f12line.strokeEnd = 1.0
      }, completion: nil)
    
    view.layer.addSublayer(replicator)
    
    delay(seconds: 3, completion: {replicator.removeFromSuperlayer()})
  }
  
  func firework1_4(at atPoint: CGPoint) {
    let replicator = CAReplicatorLayer()
    replicator.position = atPoint
    
    //line path
    let f11linePath = UIBezierPath()
    f11linePath.moveToPoint(CGPoint(x: 0, y: -10))
    f11linePath.addLineToPoint(CGPoint(x: 0, y: -100))

    let f11line = CAShapeLayer()
    f11line.path = f11linePath.CGPath
    f11line.strokeColor = UIColor.cyanColor().CGColor
    replicator.addSublayer(f11line)

    replicator.instanceCount = 20
    replicator.instanceTransform = CATransform3DMakeRotation(CGFloat(M_PI/10), 0, 0, 1)

    f11line.strokeEnd = 0
    UIView.animateWithDuration(1.0, delay: 0.33, options: [.CurveEaseOut], animations: {
      f11line.strokeEnd = 1.0
      }, completion: nil)

    //line path 2
    let f12linePath = UIBezierPath()
    f12linePath.moveToPoint(CGPoint(x: 0, y: -25))
    f12linePath.addLineToPoint(CGPoint(x: 0, y: -100))
    f12linePath.applyTransform(CGAffineTransformMakeRotation(CGFloat(M_PI/20)))

    let f12line = CAShapeLayer()
    f12line.path = f12linePath.CGPath
    f12line.lineDashPattern = [20, 2]
    f12line.strokeColor = UIColor.cyanColor().CGColor
    replicator.addSublayer(f12line)
    
    f12line.strokeEnd = 0

    UIView.animateWithDuration(1.0, delay: 0.0, options: [.CurveEaseOut], animations: {
      f12line.strokeEnd = 1.0
      }, completion: nil)

    UIView.animateWithDuration(1.0, delay: 1.0, options: [.CurveEaseIn], animations: {
      f11line.strokeStart = 1.0
      f12line.strokeStart = 0.5
      f11line.transform = CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 0, 1)
      f12line.transform = CATransform3DMakeRotation(CGFloat(M_PI_4/2), 0, 0, 1)
      
      replicator.opacity = 0.0
      }, completion: nil)


    view.layer.addSublayer(replicator)
    
    delay(seconds: 3, completion: {replicator.removeFromSuperlayer()})
  }
  
  func bang(color color: UIColor, at: CGPoint) {
    let replicator = CAReplicatorLayer()
    replicator.position = at
    view.layer.addSublayer(replicator)
    
    replicator.instanceCount = 40
    replicator.instanceTransform = CATransform3DMakeRotation(CGFloat(M_PI/20), 0, 0, 1)
    
    let dotSize: CGFloat = 2
    let dot = CALayer()
    dot.backgroundColor = color.CGColor
    dot.cornerRadius = dotSize
    dot.frame = CGRect(x: 0, y: 10, width: dotSize, height: dotSize)
    replicator.addSublayer(dot)
    
    UIView.animateWithDuration(1.5, delay: 0.0, options: [], animations: {
      dot.position.y += 30
      dot.opacity = 0.2
      }, completion: {_ in
      
    })
    
    delay(seconds: 3, completion: {replicator.removeFromSuperlayer()})
  }
  
  func animatedDot(withDistance delta: CGFloat, delay: Double) -> CALayer {
    let dot = CALayer()
    dot.backgroundColor = UIColor.cyanColor().CGColor
    dot.frame = CGRect(x: 0, y: -10, width: 1, height: 1)
  
    UIView.animateAndChainWithDuration(1.0, delay: delay, options: [.CurveEaseOut], animations: {
      dot.transform = CATransform3DMakeTranslation(0, -delta, 0)
      }, completion: nil)
      .animateWithDuration(2.0, animations: {
        dot.transform = CATransform3DConcat(dot.transform, CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 0, 1))
      })
      .animateWithDuration(1.0, animations: {
        dot.transform = CATransform3DConcat(dot.transform, CATransform3DMakeTranslation(0, -delta, 0))
        dot.opacity = 0.1
      })
    
    return dot
  }
  
  func firework2(at atPoint: CGPoint) {
    let replicator = CAReplicatorLayer()
    replicator.position = atPoint
    
    replicator.instanceCount = 40
    replicator.instanceTransform = CATransform3DMakeRotation(CGFloat(M_PI/20), 0, 0, 1)
    
    for i in 1...10 {
      replicator.addSublayer(
        animatedDot(withDistance: CGFloat(i*10), delay: 1/Double(i))
      )
    }
    
    view.layer.addSublayer(replicator)
    delay(seconds: 6, completion: {replicator.removeFromSuperlayer()})
  }
}


extension FireworksViewController: StarterProjectCode {
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController!.navigationBarHidden = false
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController!.navigationBarHidden = true
    markAsSeen(nil)
    
    let dblTap = UITapGestureRecognizer(target: self, action: "didTap:")
    dblTap.numberOfTapsRequired = 2
    view.addGestureRecognizer(dblTap)

    delay(seconds: 1, completion: startAnimation)
  }
  
  func didTap(tap: UITapGestureRecognizer) {
    print(tap.locationInView(view))
    demoStep++
  }
}
  