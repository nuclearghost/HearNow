//
//  ConcertCell.swift
//  HearNow
//
//  Created by Mark Meyer on 9/27/14.
//  Copyright (c) 2014 Mark Meyer + Ryan Loomba. All rights reserved.
//

import Foundation
import UIKit

class ConcertCell : UITableViewCell {
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        //self.imgView.layer.cornerRadius = self.imgView.frame.size.width/2;
        //self.imgView.clipsToBounds = true;
    }
}