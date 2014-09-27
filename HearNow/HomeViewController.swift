//
//  HomeViewController.swift
//  HearNow
//
//  Created by Mark Meyer on 9/27/14.
//  Copyright (c) 2014 Mark Meyer + Ryan Loomba. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, SongkickAPIProtocol {
    
    var api: SongkickAPI = SongkickAPI()
    var concerts: NSArray = NSArray()

    @IBOutlet weak var LocationSearchField: UITextField!

    @IBAction func LocationTapped(sender: AnyObject) {
        println("tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = self.UIColorFromRGB(0x26D0CE)
        self.navigationController?.navigationBar.tintColor = self.UIColorFromRGB(0x1A2980)
        
        LocationSearchField.delegate = self
        
        api.delegate = self
        api.pingSongkick()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.concerts.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ConcertCell! = self.tableView.dequeueReusableCellWithIdentifier("ConcertCell" ,forIndexPath: indexPath) as ConcertCell
        
        let rowData = self.concerts[indexPath.row] as NSDictionary
        cell.artistLabel.text = rowData["displayName"] as NSString
        
        let start = rowData["start"] as NSDictionary
        cell.dateLabel.text = start["date"] as NSString
        
        let venue = rowData["venue"] as NSDictionary
        cell.venueLabel.text = venue["displayName"] as NSString
        /*
        var imageUrl = NSURL(string: image)
        var request = NSURLRequest(URL: imageUrl)
        var requestQueue : NSOperationQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: requestQueue, completionHandler:
            {(response: NSURLResponse!, responseData: NSData!, error: NSError!) -> Void in
                if error != nil {
                    println("error")
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), {
                        cell.mioTesto.text = title
                        cell.mioSubtitle.text = subtitle
                        cell.miaImmagine.image=UIImage(data: responseData)
                        UIView.animateWithDuration(1.0,
                            delay: 0.0,
                            options: .CurveEaseInOut,
                            animations: {
                                cell.miaImmagine.alpha=1.0
                                cell.mioTesto.alpha=1.0
                                cell.mioSubtitle.alpha=1.0
                            },
                            completion: { finished in
                                
                        })
                        
                    })
                }
        })
        */
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Selected: \(indexPath.row)!")
        //performSegueWithIdentifier("miaview", sender: self.view)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //mark LocationSearchField: UITextFieldDelegate
    func textFieldDidEndEditing(textField: UITextField) {
        println("Text field did end. Text \(self.LocationSearchField.text)")
        self.LocationSearchField.resignFirstResponder()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.LocationSearchField.resignFirstResponder()
        return true
    }
    
    //mark SongkickAPI delegate
    func didRecieveResponse(results: NSDictionary) {
        //println(results)
        let resultsPage = results["resultsPage"] as NSDictionary
        let resultsD = resultsPage["results"] as NSDictionary
        let events = resultsD["event"] as NSArray
        self.concerts = events;
        tableView.reloadData()
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}