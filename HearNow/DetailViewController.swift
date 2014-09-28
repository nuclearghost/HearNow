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
        let venue = detailItem["venue"] as NSDictionary
        let lat = venue["lat"] as Double
        let lng = venue["lng"] as Double
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        self.mapView.centerCoordinate = location;
        self.mapView.camera = MKMapCamera(lookingAtCenterCoordinate: location, fromEyeCoordinate: location, eyeAltitude: 3000)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = venue["displayName"] as String
        self.mapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
