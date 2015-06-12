//
//  PostModel.swift
//  CoreImageFilterPresentation
//
//  Created by Marin Todorov on 6/1/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit

struct PostModel {
    
    let photo: UIImage
    let date: String
    let post: String
    
    static func allPosts() -> [PostModel] {
        var result:[PostModel] = []
        let list = NSArray(contentsOfFile:
            NSBundle.pathForResource("posts",
                ofType: "plist",
                inDirectory: NSBundle.mainBundle().resourcePath!)!)!
        for dictObj in list {
            let dict = dictObj as! NSDictionary
            result.append(
                PostModel(photo: UIImage(named: dict["photo"] as! String)!,
                date: dict["date"] as! String,
                post: dict["post"] as! String))
        }
        return result
    }
}