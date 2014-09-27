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
    var concerts: NSDictionary = NSDictionary()

    @IBOutlet weak var LocationSearchField: UITextField!

    @IBAction func LocationTapped(sender: AnyObject) {
        println("tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationSearchField.delegate = self
        api.delegate = self;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ConcertCell! = self.tableView.dequeueReusableCellWithIdentifier("ConcertCell" ,forIndexPath: indexPath) as ConcertCell
        
        /*
        rowData = dataArray[indexPath.row] as NSDictionary
        var title=rowData["title"] as String
        var subtitle=rowData["subtitle"] as String
        var image=rowData["thumb"] as String
        
        cell.miaImmagine.alpha=0.0
        cell.mioTesto.alpha=0.0
        cell.mioSubtitle.alpha=0.0
        
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
        api.getEventsFor(self.LocationSearchField.text)
        self.LocationSearchField.resignFirstResponder()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.LocationSearchField.resignFirstResponder()
        return true
    }
    
    //mark SongkickAPI delegate
    func didRecieveResponse(results: NSDictionary) {
       println(results)

    }
}