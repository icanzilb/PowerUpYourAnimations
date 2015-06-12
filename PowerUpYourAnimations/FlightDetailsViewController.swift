//
//  FlightDetailsViewController.swift
//  FlightsAnimationDemo
//
//  Created by Marin Todorov on 6/6/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit

class FlightDetailsViewController: UIViewController {

    var flight: FlightModel?
    var transition: TableCellAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

}

extension FlightDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! FlightCell
        
        cell.departTime.text = flight!.departTime
        cell.arrivalTime.text = flight!.arrivalTime
        cell.price.text = flight!.price
        
        return cell
    }

}