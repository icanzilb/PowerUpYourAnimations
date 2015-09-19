//
//  DemoSpringAnimationsViewController
//
//  Created by Marin Todorov on 5/29/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit

class BlueSquareViewController: UIViewController {
    
    @IBOutlet weak var blueSquare: UIView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.blueSquare.layer.borderColor = UIColor(red: 20/255.0, green: 123/255.0, blue: 195/255.0, alpha: 1.0).CGColor
        //view.transform = CGAffineTransformMakeScale(2.5, 2.5)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        UIView.animateAndChainWithDuration(0.25, delay: 0.0, options: .CurveEaseOut, animations: {
            self.blueSquare.transform = CGAffineTransformMakeScale(0.8, 0.8)
            self.blueSquare.layer.cornerRadius = 0.0
            self.blueSquare.layer.borderWidth = 5.0
            
        }, completion: nil).animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.33, initialSpringVelocity: 0.0, options: [], animations: {
            
            self.blueSquare.transform = CGAffineTransformConcat(
                CGAffineTransformMakeScale(1.33, 1.33),
                CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
            )
            self.blueSquare.layer.cornerRadius = 50.0
            self.blueSquare.layer.borderWidth = 0.0
            
        }, completion: nil)
        
    }
}


/*

UIView.animateAndChainWithDuration(0.25, delay: 0.0, options: .CurveEaseOut, animations: {

//ease out animation
self.blueSquare.transform = CGAffineTransformMakeScale(0.8, 0.8)
self.blueSquare.layer.cornerRadius = 0.0
self.blueSquare.layer.borderWidth = 5.0

}, completion: nil).animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.33, initialSpringVelocity: 0.0, options: .Repeat, animations: {

//spring animate the layer
self.blueSquare.transform = CGAffineTransformConcat(
CGAffineTransformMakeScale(1.33, 1.33),
CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
)
self.blueSquare.layer.cornerRadius = 50.0
self.blueSquare.layer.borderWidth = 0.0

}, completion: nil)

*/