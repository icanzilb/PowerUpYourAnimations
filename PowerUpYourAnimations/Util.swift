//
//  Util.swift
//  Streamify
//
//  Created by Marin Todorov on 8/11/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit

func markAsSeen(sender: UIViewController?) {
  //print("mark as seen \(sender.classForCoder.description())")
  if let sender = sender {
    NSUserDefaults.standardUserDefaults().setValue(sender.classForCoder.description(), forKey: "lastVC")
  } else {
    NSUserDefaults.standardUserDefaults().removeObjectForKey("lastVC")
  }
  NSUserDefaults.standardUserDefaults().synchronize()
}

func delay(seconds seconds: Double, completion:()->()) {
  let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
  
  dispatch_after(popTime, dispatch_get_main_queue()) {
    completion()
  }
}

protocol StarterProjectCode {}