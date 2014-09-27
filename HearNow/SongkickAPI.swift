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
    var data: NSMutableData = NSMutableData()
    var delegate: SongkickAPIProtocol?
    
    //Search SongKick
    func pingSongkick() {
        
        let APIkey = "FdFuEuAG8tXwHfe9"
        let rawURL = "http://api.songkick.com/api/3.0/metro_areas/26330/calendar.json?apikey=\(APIkey)"
        var url: NSURL = NSURL(string: rawURL)
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self,
            startImmediately: false)
        
        println("pinging SongKick API at \(url)")
        
        connection.start()
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
        
        delegate?.didRecieveResponse(jsonResult)
    }
    
}
