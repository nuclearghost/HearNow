//
//  SongKickAPI.swift
//  HearNow
//
//  Created by Ryan Loomba on 9/27/14.
//  Copyright (c) 2014 Mark Meyer + Ryan Loomba. All rights reserved.
//

import Foundation
import UIKit

protocol SongkickAPIProtocol {
    func didRecieveResponse(results: NSDictionary)
}

class SongkickAPI: NSObject {
    
    let APIkey = "FdFuEuAG8tXwHfe9"
    let metroID: String?
    var locationConnection: NSURLConnection?
    var eventsConnection: NSURLConnection?
    
    var data: NSMutableData = NSMutableData()
    var delegate: SongkickAPIProtocol?
    
    
    //Search SongKick
    
    func getEventsFor(searchQuery: String) {
        getMetroID(searchQuery)
    }
    
    func getMetroID(searchQuery: String) {
        var escapedSearchQuery: String? = searchQuery.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let rawURL = "http://api.songkick.com/api/3.0/search/locations.json?query=\(escapedSearchQuery!)&apikey=\(APIkey)"
        var url: NSURL = NSURL(string: rawURL)
        var request: NSURLRequest = NSURLRequest(URL: url)
        self.locationConnection = NSURLConnection(request: request, delegate: self,
            startImmediately: true)
        
        println("getting metro ID at \(url)")
    
    }

    func getEventsData(metrodID: NSNumber) {
        let rawURL = "http://api.songkick.com/api/3.0/metro_areas/\(metrodID)/calendar.json?apikey=\(APIkey)"
        var url: NSURL = NSURL(string: rawURL)
        var request: NSURLRequest = NSURLRequest(URL: url)
        self.eventsConnection = NSURLConnection(request: request, delegate: self,
            startImmediately: true)
        
        println("pinging events API at \(url)")
    }
    
    //NSURLConnection delegate method
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        println("Failed with error:\(error.localizedDescription)")
    }
    
    //NSURLConnection delegate method
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        //New request so we need to clear the data object
        self.data = NSMutableData()
    }
    
    //NSURLConnection delegate method
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        //Append incoming data
        self.data.appendData(data)
    }
    
    //NSURLConnection delegate method
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        //Finished receiving data and convert it to a JSON object
        var err: NSError
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data,
            options:NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        if connection == self.locationConnection {
            let resultsPage = jsonResult["resultsPage"] as NSDictionary
            let results = resultsPage["results"] as NSDictionary
            let location = results["location"] as NSMutableArray
            let firstLocation = location[0] as NSDictionary
            let metroArea = firstLocation["metroArea"] as NSDictionary
            let metroID = metroArea["id"] as NSNumber
            self.getEventsData(metroID)
        } else if connection == self.eventsConnection {
            delegate?.didRecieveResponse(jsonResult)
        }
    }
    
}
