//
//  ViewController.swift
//  FlightsAnimationDemo
//
//  Created by Marin Todorov on 6/6/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit

class FlightsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var flights: [FlightModel] = []
    var lastSelectedIndexPath: NSIndexPath?
    
    let transition = TableCellAnimator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self

        flights = FlightModel.allFlights()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? FlightDetailsViewController {
            destination.flight = flights[lastSelectedIndexPath!.row]
        }
    }
    
    func selectedCellSnapshot() -> UIView {
        let cell = tableView.cellForRowAtIndexPath(lastSelectedIndexPath!)!
        let result = cell.snapshotViewAfterScreenUpdates(false)
        result.frame = cell.convertRect(cell.bounds, toView: view)
        return result
    }
}

// MARK: table view methods

extension FlightsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! FlightCell
        
        let flight = flights[indexPath.row]
        cell.departTime.text = flight.departTime
        cell.arrivalTime.text = flight.arrivalTime
        cell.price.text = flight.price

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        lastSelectedIndexPath = indexPath
        return indexPath
    }
}

// MARK: navigation controller - custom transition methods

extension FlightsViewController: UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .Pop {
            return nil
        }
        return transition
    }
}

