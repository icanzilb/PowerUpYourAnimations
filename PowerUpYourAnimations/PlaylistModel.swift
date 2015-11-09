//
//  FlightModel.swift
//  FlightsAnimationDemo
//
//  Created by Marin Todorov on 6/6/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import Foundation

struct PlaylistModel {
    
    let name: String
    let style: String
    let songs: [String]
    
    static func allPlaylists() -> [PlaylistModel] {
        var result:[PlaylistModel] = []
        let list = NSArray(contentsOfFile:
            NSBundle.pathForResource("playlists",
                ofType: "plist",
                inDirectory: NSBundle.mainBundle().resourcePath!)!)!
        for dictObj in list {
            let dict = dictObj as! NSDictionary
            result.append(
                PlaylistModel(
                    name: dict["name"] as! String,
                    style: dict["style"] as! String,
                    songs: dict["songs"] as! Array))
        }
        return result
    }

}