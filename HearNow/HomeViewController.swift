//
//  HomeViewController.swift
//  HearNow
//
//  Created by Mark Meyer on 9/27/14.
//  Copyright (c) 2014 Mark Meyer + Ryan Loomba. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var LocationSearchField: UITextField!

    @IBAction func LocationTapped(sender: AnyObject) {
        println("tapped")
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        println("Text field done. Text \(self.LocationSearchField.text)")
    }
    
}