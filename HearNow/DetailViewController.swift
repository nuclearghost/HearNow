//
//  DetailViewController.swift
//  HearNow
//
//  Created by Ryan Loomba on 9/27/14.
//  Copyright (c) 2014 Mark Meyer + Ryan Loomba. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailItem: NSDictionary!

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var venueName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    
    override func viewDidLoad() {
        println(detailItem)
        self.eventTitle.text = detailItem["displayName"] as String
        let venue = detailItem["venue"] as NSDictionary
        self.venueName.text = venue["displayName"] as String
        let start = detailItem["start"] as NSDictionary
        self.eventDate.text = start["date"] as String
        self.setTitleWithArtistDisplayName()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setTitleWithArtistDisplayName() {
        let performances = detailItem["performance"] as NSMutableArray
        let performance = performances[0] as NSDictionary
        let artist = performance["artist"] as NSDictionary
        let displayName = artist["displayName"] as String
        self.title = displayName
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
