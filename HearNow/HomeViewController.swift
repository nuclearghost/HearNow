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
        // Do any additional setup after loading the view, typically from a nib.
        api.delegate = self;
        api.getEventsFor("SanFrancisco")
    }

    
    func textFieldDidEndEditing(textField: UITextField) {
        println("Text field done. Text \(self.LocationSearchField.text)")
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        println("Text field done. Text \(self.LocationSearchField.text)")
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        println("Text field done. Text \(self.LocationSearchField.text)")
        return true
    }
    
    func didRecieveResponse(results: NSDictionary) {
        // Store the results in our table data array
       println(results)
    }
}