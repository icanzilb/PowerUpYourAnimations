//
//  TableCellAnimator.swift
//  FlightsAnimationDemo
//
//  Created by Marin Todorov on 6/6/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit

class TableCellAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! FlightsViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! FlightDetailsViewController
        
        transitionContext.containerView().insertSubview(toVC.view, belowSubview: fromVC.view)
        
        //make a snapshot of the selected cell
        let cellView = fromVC.selectedCellSnapshot()
        transitionContext.containerView().addSubview(cellView)

        
        let width = fromVC.view.bounds.size.width
        toVC.view.transform = CGAffineTransformMakeTranslation(width, 0.0)

        (UIApplication.sharedApplication().windows.first as! UIWindow).backgroundColor = UIColor.whiteColor()
        
        let duration = transitionDuration(transitionContext)
        
        UIView.animateAndChainWithDuration(NSTimeInterval(duration/4), delay: NSTimeInterval(0.0), options: [], animations: {
            //1st animation
            fromVC.view.transform = CGAffineTransformMakeTranslation(-width, 0.0)
            
        }, completion:nil).animateWithDuration(duration/4, animations: {
            //2nd animation
            cellView.center.y = cellView.bounds.size.height/2 + fromVC.topLayoutGuide.length
            
        }).animateWithDuration(duration/4, animations: {
            //3rd animation
            toVC.view.transform = CGAffineTransformIdentity
            
        }).animateWithDuration(duration/4, animations: {
            //4th animation
            cellView.alpha = 0.0
            
        }, completion: {_ in
            //animation completed
            
            fromVC.view.transform = CGAffineTransformIdentity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
            
    }
    
}

/*

let cellView = fromVC.selectedCellSnapshot()
transitionContext.containerView().addSubview(cellView)

cellView.center.y = cellView.bounds.size.height/2 + fromVC.topLayoutGuide.length

cellView.alpha = 0.0

*/