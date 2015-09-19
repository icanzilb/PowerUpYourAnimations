//
//  RevealAnimator.swift
//  LogoReveal
//
//  Created by Marin Todorov on 1/15/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class CoreImageAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {

    var animationDuration: CFTimeInterval {
        get {
            return (presenting) ? 0.25 : 1.5
        }
    }

    var presenting = true
    var interactive = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        if presenting {
            
            // PRESENT
            
            let nav = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! UINavigationController
            let fromVC = nav.topViewController as! TimelineViewController
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! PhotoDetailViewController
            
            transitionContext.containerView().addSubview(toVC.view)
            
            toVC.view.backgroundColor = UIColor.clearColor()
            toVC.imageView.center.y += 20.0
            toVC.imageView.alpha = 0.0
            
            UIView.animateWithDuration(animationDuration, delay: 0.0, options: .CurveEaseOut, animations: {
                toVC.imageView.center.y -= 20.0
                toVC.imageView.alpha = 1.0
            }, completion: {_ in
                    transitionContext.completeTransition(true)
            })
            
        } else {
            
            // DISMISS
            
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)! as! PhotoDetailViewController
            let nav = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! UINavigationController
            let toVC = nav.topViewController as! TimelineViewController
            
            
            UIView.animateWithDuration(animationDuration, delay: 0.0, options: .CurveEaseIn, animations: {
                
                fromVC.imageView.alpha = 0.85
                fromVC.imageView.transitionToImage(UIImage(named: "transparent.png")!)
            }, completion: {_ in
                
                transitionContext.completeTransition(true)
            })
            
        }
    }
    
}
