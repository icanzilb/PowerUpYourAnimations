//
//  TransitionImageView.swift
//  CITransitions
//
//  Created by Marin Todorov on 6/1/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit
import CoreImage

class TransitionImageView: UIImageView {
    
    @IBInspectable var duration: Double = 2.0
    
    private let filter = CIFilter(name: "CIDisintegrateWithMaskTransition")!
    
    private var transitionStartTime: CFTimeInterval = 0.0
    private var displayLink: CADisplayLink?
    
    @IBInspectable var maskImage: UIImage?
    
    func transitionToImage(toImage: UIImage) {
        
        guard let image = image, let maskImage = maskImage else {
            fatalError("You need to have set an image, provide a new image and a mask to fire up a transition")
        }
        
        filter.setValue(CIImage(image: image),
            forKey: kCIInputImageKey)
        filter.setValue(CIImage(image: toImage),
            forKey: kCIInputTargetImageKey)
        filter.setValue(CIImage(image: maskImage),
            forKey: kCIInputMaskImageKey)
        
        if let displayLink = displayLink {
            displayLink.invalidate()
        }
        
        transitionStartTime = CACurrentMediaTime()
        
        displayLink = CADisplayLink(target: self, selector: Selector("timerFired:"))
        displayLink!.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
    }
    
    func timerFired(link: CADisplayLink) {

        let progress = (CACurrentMediaTime() - transitionStartTime) / duration
        filter.setValue(progress, forKey: kCIInputTimeKey)
        image = UIImage(CIImage: filter.outputImage!,
            scale: UIScreen.mainScreen().scale,
            orientation: UIImageOrientation.Up)
        
        if CACurrentMediaTime() > transitionStartTime + duration {
            image = filter.valueForKey(kCIInputTargetImageKey) as? UIImage
            link.invalidate()
        }
    }
    
}