//
//  PhotoDetailViewController.swift
//  CoreImageFilterPresentation
//
//  Created by Marin Todorov on 6/1/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
  
  var imageView: TransitionImageView!
  
  var post: PostModel?
  weak var animator: CoreImageAnimator?
  
  var maskImageName: String?
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    if let masterVC = (presentingViewController as! UINavigationController).viewControllers.first as? TimelineViewController {
      animator = masterVC.transition
    }
    
    imageView = TransitionImageView()
    imageView.frame = CGRect(x: 0, y: 0, width: post!.photo.size.width, height: post!.photo.size.height)
    let scale: CGFloat = view.frame.size.height / post!.photo.size.height
    imageView.transform = CGAffineTransformMakeScale(scale, scale)
    imageView.center = view.center
    imageView.image = post?.photo
    imageView.maskImage = UIImage(named: "\(maskImageName!)-Mask.jpg")
    
    imageView.userInteractionEnabled = true
    
    imageView.addGestureRecognizer(
      UITapGestureRecognizer(target: self, action: Selector("actionClose:"))
    )
    
    view.addSubview(imageView)
  }
  
  func actionClose(sender: AnyObject) {
    if let animator = animator {
      animator.presenting = false
      imageView.duration = animator.animationDuration
      dismissViewControllerAnimated(true, completion: nil)
    }
  }
}
