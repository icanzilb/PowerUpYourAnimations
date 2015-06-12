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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // configure the appearance of the selection
        
        selection.fillColor = UIColor.clearColor().CGColor
        selection.strokeColor = UIColor.whiteColor().CGColor
        selection.lineWidth = 3.0
        selection.shadowOpacity = 0.25
        selection.shadowOffset = CGSize(width: 1, height: 1)
        selection.shadowRadius = 0.1
        
        view.layer.addSublayer(selection)
        
        //configure the dash pattern
        selection.lineDashPattern = [5, 3]
    }
 
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        
        // make the selection frame rect
        let location = (touches.first as! UITouch).locationInView(view)
        let selectionRect = CGRect(
            x: view.center.x - abs(location.x - view.center.x),
            y: view.center.y - abs(location.y - view.center.y),
            width: 2 * abs(location.x - view.center.x),
            height: 2 * abs(location.y - view.center.y)
        )

        selection.path = UIBezierPath(rect: selectionRect).CGPath
        
        //let the ants march!
        UIView.animateWithDuration(0.5, delay: 0.0, options: .Repeat | .CurveLinear, animations: {
            self.selection.lineDashPhase = 8.0
        }, completion: nil)
    }
    
}

/*

selection.lineDashPattern = [5, 3]


// marching ants!
UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveLinear | .Repeat, animations: {
self.selection.lineDashPhase = 8.0
}, completion: nil)

*/