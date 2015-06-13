//
//  ViewController.swift
//  CoreImageFilterPresentation
//
//  Created by Marin Todorov on 6/1/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {

    var posts: [PostModel] = []
    let transition = CoreImageAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()

        //load posts from posts.plist
        posts = PostModel.allPosts()
        btnMask.title = masks[currentMaskIndex]
        
        if UIDevice.currentDevice().model.hasSuffix("Simulator") {
            let alert = UIAlertController(title: "Super fatal error", message: "Run on device!", preferredStyle: UIAlertControllerStyle.Alert)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: table view methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! PostCell

        let post = posts[indexPath.row]
        
        cell.photo.image = post.photo
        cell.date.text = "Marin posted on " + post.date
        cell.post.text = post.post
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let destination = storyboard?.instantiateViewControllerWithIdentifier("PhotoDetailViewController") as? PhotoDetailViewController {
            destination.post = posts[indexPath.row]
            destination.modalPresentationStyle = .Custom
            destination.transitioningDelegate = self
            destination.maskImageName = masks[currentMaskIndex]
            presentViewController(destination, animated: true, completion: nil)
        }
    }
    
    // MARK: presentation methods
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = true
        transition.interactive = false
        return transition
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        transition.interactive = false
        return transition
    }
    
    // MARK: Mask selection
    var currentMaskIndex = 0
    let masks = ["Puzzle", "GlassTiles", "Microbes", "Patches", "Poster", "Sponge", "AltConf"]
    
    @IBOutlet weak var btnMask: UIBarButtonItem!
    
    @IBAction func actionToggleMask(sender: AnyObject) {
        currentMaskIndex++
        if currentMaskIndex == masks.count {
            currentMaskIndex = 0
        }
        btnMask.title = masks[currentMaskIndex]
    }
}

