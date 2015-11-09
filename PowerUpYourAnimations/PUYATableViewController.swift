//
//  PUYATableTableViewController.swift
//  PowerUpYourAnimations
//
//  Created by Marin Todorov on 10/1/15.
//  Copyright © 2015 Underplot ltd. All rights reserved.
//

import UIKit

class PUYATableViewController: UITableViewController {
  
  var initialAppearance = true
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    guard initialAppearance else {
      return
    }
    
    if let vcName = NSUserDefaults.standardUserDefaults().valueForKey("lastVC") as? String {
      let vcStoryboardID = vcName.componentsSeparatedByString(".").last!
      
      if let vc = storyboard?.instantiateViewControllerWithIdentifier(vcStoryboardID) {
        navigationController?.pushViewController(vc, animated: false)
      }
      
    }
    
    initialAppearance = false
  }
}
