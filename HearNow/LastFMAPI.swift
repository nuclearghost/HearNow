//
//  LastFMAPI.swift
//  HearNow
//
//  Created by Mark Meyer on 9/27/14.
//  Copyright (c) 2014 Mark Meyer + Ryan Loomba. All rights reserved.
//

import Foundation

protocol LastFMAPIProtocol {
    func didRecieveArtistResponse(results: NSDictionary)
}

class LastFMAPI : NSObject {
    
    let APIKey = "de78baf5d8626a8fb08cffef3b517582"
    var delegate: LastFMAPIProtocol?
    var data: NSMutableData = NSMutableData()
    
    var artistCache = Dictionary<String, NSDictionary>()
    
    func findArtist(searchQuery: String) {
        println(searchQuery)
        if let artist = artistCache[searchQuery] {
            delegate?.didRecieveArtistResponse(artist)
        } else {
            var escapedSearchQuery: String? = searchQuery.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            let rawURL = "http://ws.audioscrobbler.com/2.0/?method=artist.search&artist=\(escapedSearchQuery!)&api_key=de78baf5d8626a8fb08cffef3b517582&format=json"
            let url = NSURL(string: rawURL)
            let request = NSURLRequest(URL: url)
            NSURLConnection(request: request, delegate: self, startImmediately: true)
            
            println("Pinging LastFM API at \(rawURL)")
        }
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
        
        var artist: NSDictionary
        
        let results = jsonResult["results"] as NSDictionary
        let count = results["opensearch:totalResults"] as String
        if (count.toInt() > 1) {
            let artistMatches = results["artistmatches"] as NSDictionary
            let artists = artistMatches["artist"] as NSArray
            artist = artists[0] as NSDictionary
            
            artistCache[artist["name"] as String] = artist
            
            delegate?.didRecieveArtistResponse(artist)
        } else {
            //TODO: Fix This
            //let artistMatches = results["artistmatches"] as NSDictionary
            //artist = artistMatches["artist"] as NSDictionary
        }

    }

}