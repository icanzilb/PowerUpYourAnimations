//
//  FlightModel.swift
//  FlightsAnimationDemo
//
//  Created by Marin Todorov on 6/6/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import Foundation

struct FlightModel {
    
    let departTime: String
    let arrivalTime: String
    let price: String
    
    static func allFlights() -> [FlightModel] {
        var result:[FlightModel] = []
        let list = NSArray(contentsOfFile:
            NSBundle.pathForResource("flights",
                ofType: "plist",
                inDirectory: NSBundle.mainBundle().resourcePath!)!)!
        for dictObj in list {
            let dict = dictObj as! NSDictionary
            result.append(
                FlightModel(departTime: dict["departing"] as! String,
                    arrivalTime: dict["arriving"] as! String,
                    price: dict["price"] as! String))
        }
        return result
    }

}