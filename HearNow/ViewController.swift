//
//  ViewController.swift
//  HearNow
//
//  Created by Mark Meyer on 9/27/14.
//  Copyright (c) 2014 Mark Meyer + Ryan Loomba. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SongkickAPIProtocol {
    
    var api: SongkickAPI = SongkickAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        api.delegate = self;
        api.pingSongkick()
    }
    ;
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didRecieveResponse(results: NSDictionary) {
        // Store the results in our table data array
        println(results)
    }


}

