//
//  HomeViewController.swift
//  HearNow
//
//  Created by Mark Meyer on 9/27/14.
//  Copyright (c) 2014 Mark Meyer + Ryan Loomba. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UITableViewController, UITextFieldDelegate, SongkickAPIProtocol {
    
    var api: SongkickAPI = SongkickAPI()

    @IBOutlet weak var LocationSearchField: UITextField!

    @IBAction func LocationTapped(sender: AnyObject) {
        println("tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationSearchField.delegate = self
        
        api.delegate = self
        api.pingSongkick()
    }

    
    func textFieldDidEndEditing(textField: UITextField) {
        println("Text field did end. Text \(self.LocationSearchField.text)")
        self.LocationSearchField.resignFirstResponder()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.LocationSearchField.resignFirstResponder()
        return true
    }
    
    func didRecieveResponse(results: NSDictionary) {
        // Store the results in our table data array
        println(results)
    }
}