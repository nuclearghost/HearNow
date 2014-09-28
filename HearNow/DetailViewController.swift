//
//  DetailViewController.swift
//  HearNow
//
//  Created by Ryan Loomba on 9/27/14.
//  Copyright (c) 2014 Mark Meyer + Ryan Loomba. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    var detailItem: NSDictionary!

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var venueName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println(detailItem)
        self.eventTitle.text = detailItem["displayName"] as? String
        self.setTitleWithArtistDisplayName()
        self.initMap()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let eventURL: AnyObject? = detailItem["uri"]
        (segue.destinationViewController as WebViewController).eventURL = eventURL as? String
    }

    
    func setTitleWithArtistDisplayName() {
        let performances = detailItem["performance"] as NSMutableArray
        let performance = performances[0] as NSDictionary
        let artist = performance["artist"] as NSDictionary
        let displayName = artist["displayName"] as String
        self.title = displayName
    }
    
    func initMap() {
        let location = CLLocationCoordinate2D(latitude: 22, longitude: -122)
        self.mapView.centerCoordinate = location;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
